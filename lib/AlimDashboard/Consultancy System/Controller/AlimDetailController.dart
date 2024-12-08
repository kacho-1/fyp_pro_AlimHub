import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class AddConsultancyController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final controller = Get.put(ProfileController());

  Future<void> saveConsultancyDetails({
    required String experience,
    required String fee,
    required String specialty,
    required String about,
  }) async {
    try {
      // Get the current user's uid
      final String alimUid = _auth.currentUser?.uid ?? '';
      final String imageUrl = controller.imageUrl.value;
      final String name = controller.name.value;

      if (alimUid.isEmpty) {
        Get.snackbar('Error', 'User not authenticated!',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Reference to the Alim's document in Firestore
      final alimDocRef = _firestore.collection('alim_availability').doc(alimUid);

      // Check if the Alim already has consultancy details saved
      final docSnapshot = await alimDocRef.get();
      if (docSnapshot.exists) {
        // If document exists, show a message saying the record already exists
        Get.snackbar('Error', 'Record already exists. You cannot add the same details again.',
            snackPosition: SnackPosition.BOTTOM);
        return; // Don't proceed with saving the details
      }

      // If no document exists, save the new consultancy details
      await alimDocRef.set({
        'experience': experience,
        'fee': fee,
        'specialty': specialty,
        'about': about,
        'alimUid': alimUid,
        'alimimage': imageUrl,
        'alimname': name,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // Merge data to avoid overwriting

      Get.snackbar('Success', 'Details saved successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save details: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
