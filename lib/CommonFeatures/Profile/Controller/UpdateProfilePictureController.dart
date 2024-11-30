
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_io/io.dart';

import 'Profilecontroller.dart';


class ChangeProfileController extends GetxController {
  static ChangeProfileController get instance => Get.find();

  // Get instance of ProfileController
  final ProfileController profileController = ProfileController.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Uploads the new image to Firebase Storage, deletes the old image if it exists, and updates Firestore
  Future<void> updateProfilePicture(String newImagePath) async {
    String userId = profileController.userId; // Get userId from ProfileController
    String currentImageUrl = profileController.imageUrl.value; // Current profile image URL

    if (userId.isEmpty) {
      print("User ID is not available");
      return;
    }

    try {
      // Delete old profile picture if it exists
      if (currentImageUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(currentImageUrl).delete();
        print("Old profile picture deleted.");
      }

      // Upload the new profile picture
      File newImageFile = File(newImagePath);
      String storagePath = 'uploads/pic/$userId';
      await FirebaseStorage.instance.ref(storagePath).putFile(newImageFile);

      // Get the download URL for the uploaded file
      String newImageUrl = await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

      // Update the imageUrl in Firestore
      await _firestore.collection('Public').doc(userId).update({
        'imageUrl': newImageUrl,
      });

      // Update imageUrl in ProfileController for real-time UI changes
      profileController.imageUrl.value = newImageUrl;
      print("Profile picture updated successfully.");

    } catch (e) {
      print("Error updating profile picture: $e");
    }
  }
}
