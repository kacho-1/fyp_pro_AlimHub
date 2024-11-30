import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profilescreen.dart';

class UpdateDobrController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final updateDOBFormKey = GlobalKey<FormState>();

  // Observable variable for the user's name
  RxString dob = ''.obs;

  // Observable controller for the text field
  Rx<TextEditingController> dobController = TextEditingController().obs;

  // Function to load the user's name from Firestore
  Future<void> loaddob() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        dob.value = alimDoc['dob'];
        dobController.value.text = alimDoc['dob'];
      } else {
        // If not found in Alim, check the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          dob.value = publicDoc['dob'];
          dobController.value.text = publicDoc['dob'];
        }
      }
    }
  }
  void setDOB(DateTime date) {
    dobController.value.text = '${date.day}-${date.month}-${date.year}';
  }

  Future<void> updateDob() async {
    String newDob = dobController.value.text.trim();
    String userId = _auth.currentUser?.uid ?? '';

    if (newDob.isNotEmpty && userId.isNotEmpty) {
      // Update the local observable variable before saving
      dob.value = newDob; // Update the observable here

      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        await _firestore.collection('Alim').doc(userId).update(
            {'dob': newDob});
        Get.snackbar('Success', 'Date of Birth is  updated successfully!');
      } else {
        // If the user is in the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          await _firestore.collection('Public').doc(userId).update(
              {'dob': newDob});
          Get.snackbar('Success', 'Date of Birth is updated successfully!');
        }
      }
      // Optionally navigate back to the ProfileScreen
      Get.off(() => ProfileScreen());
    } else {
      // Show error message if the name is empty
      Get.snackbar('Error', 'Dob cannot be empty!');
    }
  }
}