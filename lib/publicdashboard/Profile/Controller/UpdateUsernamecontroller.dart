import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Profile/profilescreen.dart';
import 'package:get/get.dart';

class UpdateUserNameController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // Observable variable for the user's name
  RxString userName = ''.obs;

  // Observable controller for the text field
  Rx<TextEditingController> usernameController = TextEditingController().obs;

  // Function to load the user's name from Firestore
  Future<void> loadUserName() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim').doc(userId).get();

      if (alimDoc.exists) {
        userName.value = alimDoc['username'];
        usernameController.value.text = alimDoc['username'];
      } else {
        // If not found in Alim, check the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(userId).get();

        if (publicDoc.exists) {
          userName.value = publicDoc['username'];
          usernameController.value.text = publicDoc['username'];
        }
      }
    }
  }

  // Function to update the user's name in Firestore
  Future<void> updateUserName() async {
    String newUsername = usernameController.value.text.trim();
    String userId = _auth.currentUser?.uid ?? '';

    if (newUsername.isNotEmpty && userId.isNotEmpty) {
      // Update the local observable variable before saving
      userName.value = newUsername; // Update the observable here

      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim').doc(userId).get();

      if (alimDoc.exists) {
        await _firestore.collection('Alim').doc(userId).update({'username': newUsername});
        Get.snackbar('Success', 'Username updated successfully!');
      } else {
        // If the user is in the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(userId).get();

        if (publicDoc.exists) {
          await _firestore.collection('Public').doc(userId).update({'username': newUsername});
          Get.snackbar('Success', 'Username updated successfully!');
        }
      }

      // Optionally navigate back to the ProfileScreen
      Get.off(() => ProfileScreen());
    } else {
      // Show error message if the name is empty
      Get.snackbar('Error', 'Name cannot be empty!');
    }
  }
}
