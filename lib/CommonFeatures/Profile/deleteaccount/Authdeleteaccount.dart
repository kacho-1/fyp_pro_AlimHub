import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_pro/Authentication/SignIn.dart';
import 'package:fyp_pro/Authentication/SignUp.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Controller/Profilecontroller.dart';

class DeleteAccountAuthScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final controller = ProfileController();


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DeleteAccountAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Account Deletion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please enter your email and password to confirm account deletion:'),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _verifyUser();
              },
              child: const Text('Confirm Deletion'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Re-authenticate user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Proceed to delete account
      if (userCredential.user != null) {
        await deleteAccount(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Authentication failed');
    }
  }

  Future<void> deleteAccount(String userId) async {
    try {
      // Check if the user is in the 'Alim' collection
      DocumentReference alimDocRef = _firestore.collection('Alim').doc(userId);
      DocumentSnapshot alimDocSnapshot = await alimDocRef.get();

      if (alimDocSnapshot.exists) {
        // Delete from 'Alim' collection
        await alimDocRef.delete();
      } else {
        // If not found in 'Alim', check 'Public' collection
        DocumentReference publicDocRef = _firestore.collection('Public').doc(userId);
        DocumentSnapshot publicDocSnapshot = await publicDocRef.get();

        if (publicDocSnapshot.exists) {
          // Delete from 'Public' collection
          await publicDocRef.delete();
        } else {
          Get.snackbar('Error', 'User not found in any collection.');
          return;
        }
      }

      // Delete profile picture from Firebase Storage
      try {
        await _storage.ref('uploads/pic/$userId').delete();
        print('Profile picture deleted successfully');
      } catch (storageError) {
        print('Error deleting profile picture: $storageError');
        Get.snackbar('Error', 'Could not delete profile picture. Please try again.');
      }

      // Delete user from Firebase Authentication
      User? user = _auth.currentUser;
      if (user != null && user.uid == userId) {
        await user.delete();
        Get.snackbar('Success', 'Your account has been deleted successfully.');
      }

      // Sign out user and navigate to Sign-In page
      await _auth.signOut();
      Get.offAll(() => Signin()); // Replace with your sign-in page widget
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    }
  }

}



