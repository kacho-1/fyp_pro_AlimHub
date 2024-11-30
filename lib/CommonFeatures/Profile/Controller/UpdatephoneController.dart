import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profilescreen.dart';

class UpdatePhoneNumberController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  // Observable variable for the user's name
  RxString phoneNumber = ''.obs;

  // Observable controller for the text field
  Rx<TextEditingController> phoneController = TextEditingController().obs;

  // Function to load the user's name from Firestore
  Future<void> loadPhoneNumber() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        phoneNumber.value = alimDoc['phone'];
        phoneController.value.text = alimDoc['phone'];
      } else {
        // If not found in Alim, check the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          phoneNumber.value = publicDoc['phone'];
          phoneController.value.text = publicDoc['phone'];
        }
      }
    }
  }

  // Function to update the user's name in Firestore
  Future<void> updatePhoneNumber() async {
    String newNumber = phoneController.value.text.trim();
    String userId = _auth.currentUser?.uid ?? '';

    if (newNumber.isNotEmpty && userId.isNotEmpty) {
      // Update the local observable variable before saving
      phoneNumber.value = newNumber; // Update the observable here

      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        await _firestore.collection('Alim').doc(userId).update(
            {'phone': newNumber});
        Get.snackbar('Success', 'Phone Number is  updated successfully!');
      } else {
        // If the user is in the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          await _firestore.collection('Public').doc(userId).update(
              {'phone': newNumber});
          Get.snackbar('Success', 'Phone Number is updated successfully!');
        }
      }
      // Optionally navigate back to the ProfileScreen
      Get.off(() => ProfileScreen());
    } else {
      // Show error message if the name is empty
      Get.snackbar('Error', 'Phone Number cannot be empty!');
    }
  }
}