import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Profile/profilescreen.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // Observable variable for the user's name
  RxString userName = ''.obs;
  // Observable controller for the text field
  Rx<TextEditingController> nameController = TextEditingController().obs;

  // Function to load the user's name from Firestore
  Future<void> loadUserName() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim').doc(userId).get();

      if (alimDoc.exists) {
        userName.value = alimDoc['name'];
        nameController.value.text = alimDoc['name'];
      } else {
        // If not found in Alim, check the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(userId).get();

        if (publicDoc.exists) {
          userName.value = publicDoc['name'];
          nameController.value.text = publicDoc['name'];
        }
      }
    }
  }

  // Function to update the user's name in Firestore
  Future<void> updateUserName() async {
    String newName = nameController.value.text.trim();
    String userId = _auth.currentUser?.uid ?? '';

    if (newName.isNotEmpty && userId.isNotEmpty) {
      // Update the local observable variable before saving
      userName.value = newName; // Update the observable here

      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim').doc(userId).get();

      if (alimDoc.exists) {
        await _firestore.collection('Alim').doc(userId).update({'name': newName});
        Get.snackbar('Success', 'Name updated successfully!');
      } else {
        // If the user is in the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(userId).get();

        if (publicDoc.exists) {
          await _firestore.collection('Public').doc(userId).update({'name': newName});
          Get.snackbar('Success', 'Name updated successfully!');
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


