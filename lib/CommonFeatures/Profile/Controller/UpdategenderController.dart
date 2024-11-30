import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profilescreen.dart';

class UpdateGenderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Form key
  GlobalKey<FormState> updateGenderFormKey = GlobalKey<FormState>();

  // Observable variable for the user's selected gender
  RxString selectedGender = ''.obs;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  // Function to load the user's gender from Firestore
  Future<void> loadGenderDetail() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        selectedGender.value = alimDoc['gender'];
      } else {
        // If not found in Alim, check the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          selectedGender.value = publicDoc['gender'];
        }
      }
    }
  }

  // Function to update the user's gender in Firestore
  Future<void> updateGender() async {
    String userId = _auth.currentUser?.uid ?? '';

    if (selectedGender.isNotEmpty && userId.isNotEmpty) {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim')
          .doc(userId)
          .get();

      if (alimDoc.exists) {
        await _firestore.collection('Alim').doc(userId).update(
            {'gender': selectedGender.value});
        Get.snackbar('Success', 'Your gender has been updated successfully!');
      } else {
        // If the user is in the Public collection
        DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(
            userId).get();

        if (publicDoc.exists) {
          await _firestore.collection('Public').doc(userId).update(
              {'gender': selectedGender.value});
          Get.snackbar('Success', 'Your gender has been updated successfully!');
        }
      }
      // Optionally navigate back to the ProfileScreen
      Get.off(() => ProfileScreen());
    } else {
      // Show error message if gender is not selected
      Get.snackbar('Error', 'Please select a gender!');
    }
  }
}
