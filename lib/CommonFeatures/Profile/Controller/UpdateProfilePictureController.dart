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
      // Determine the user's type (Alim or Public) by checking Firestore collections
      String userType = await _getUserType(userId);

      if (userType.isEmpty) {
        print("User type not found.");
        return;
      }

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

      // Update the imageUrl in Firestore for the appropriate collection
      await _firestore.collection(userType).doc(userId).update({
        'imageUrl': newImageUrl,
      });

      // Update imageUrl in ProfileController for real-time UI changes
      profileController.imageUrl.value = newImageUrl;
      print("Profile picture updated successfully.");

    } catch (e) {
      print("Error updating profile picture: $e");
    }
  }

  // Helper method to determine if the user is an Alim or Public user
  Future<String> _getUserType(String userId) async {
    try {
      // Check the 'Alim' collection
      DocumentSnapshot alimDoc = await _firestore.collection('Alim').doc(userId).get();
      if (alimDoc.exists) {
        return 'Alim';
      }

      // Check the 'Public' collection
      DocumentSnapshot publicDoc = await _firestore.collection('Public').doc(userId).get();
      if (publicDoc.exists) {
        return 'Public';
      }

      // If user is not found in either collection
      return '';
    } catch (e) {
      print("Error determining user type: $e");
      return '';
    }
  }
}
