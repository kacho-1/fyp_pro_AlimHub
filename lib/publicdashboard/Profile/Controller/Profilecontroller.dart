import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  String get userId {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
  // Observable variables to hold user data
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString dob = ''.obs;
  RxString gender = ''.obs;
  RxString username = ''.obs;
  RxString qualification = ''.obs;
  RxString address = ''.obs;
  RxString institution = ''.obs;
  RxString experience = ''.obs;
  RxString country = ''.obs;
  RxString state = ''.obs;
  RxString city = ''.obs;
  RxString imageUrl = ''.obs;

  // Get the currently authenticated user
  User? user = FirebaseAuth.instance.currentUser;

  // Method to fetch user data from Firestore
  Future<void> getUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot;

        // Try fetching from the 'Alim' collection first
        documentSnapshot = await FirebaseFirestore.instance.collection('Alim').doc(user!.uid).get();

        // If not found in 'Alim', check in 'Public'
        if (!documentSnapshot.exists) {
          documentSnapshot = await FirebaseFirestore.instance.collection('Public').doc(user!.uid).get();
        }

        // Check if the document exists
        if (documentSnapshot.exists) {
          // Update observable variables based on the collection type
          if (documentSnapshot.reference.parent.id == 'Alim') {
            name.value = documentSnapshot['name'] ?? '';
            email.value = documentSnapshot['email'] ?? '';
            phone.value = documentSnapshot['phone'] ?? '';
            qualification.value = documentSnapshot['qualification'] ?? '';
            address.value = documentSnapshot['address'] ?? '';
            institution.value = documentSnapshot['institution'] ?? '';
            experience.value = documentSnapshot['experience'] ?? '';
            country.value = documentSnapshot['country'] ?? '';
            state.value = documentSnapshot['state'] ?? '';
            city.value = documentSnapshot['city'] ?? '';
            imageUrl.value = documentSnapshot['imageUrl'] ?? '';
            dob.value = documentSnapshot['dob'] ?? '';
            username.value = documentSnapshot ['username'] ?? '';
            gender.value = documentSnapshot ['gender'] ?? '';
          } else {
            name.value = documentSnapshot['name'] ?? '';
            email.value = documentSnapshot['email'] ?? '';
            imageUrl.value = documentSnapshot['imageUrl'] ?? '';
            dob.value = documentSnapshot['dob'] ?? '';
            username.value = documentSnapshot ['username'] ?? '';
            gender.value = documentSnapshot ['gender'] ?? '';
            phone.value = documentSnapshot['phone'] ?? '';
          }
        } else {
          print('User document does not exist in both collections.');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('No user is currently signed in');
    }
  }


  @override
  void onInit() {
    super.onInit();
    // Call the getUserData method to fetch user data on initialization
    getUserData();
  }
}
