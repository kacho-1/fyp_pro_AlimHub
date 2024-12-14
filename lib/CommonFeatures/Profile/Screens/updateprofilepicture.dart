import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Controller/UpdateProfilePictureController.dart';

class ChangeProfilePictureScreen extends StatelessWidget {
  // Access ChangeProfileController
  final controller = Get.put(ChangeProfileController());

  // For selecting an image
  final ImagePicker _picker = ImagePicker();

  ChangeProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile Picture'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display selected image
              Obx(() {
                final selectedImagePath = controller.profileController.selectedImagePath.value;
                final currentImageUrl = controller.profileController.imageUrl.value;

                return selectedImagePath.isNotEmpty
                    ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(selectedImagePath)),
                )
                    : currentImageUrl.isNotEmpty
                    ? CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(currentImageUrl),
                )
                    : CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                );
              }),
              const SizedBox(height: 20),

              // Button to pick a new image
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    // Update selectedImagePath immediately
                    controller.profileController.selectedImagePath.value = pickedFile.path;
                  }
                },
                child: const Text('Choose New Profile Picture'),
              ),
              const SizedBox(height: 20),

              // Button to update the profile picture
              ElevatedButton(
                onPressed: () async {
                  final newImagePath = controller.profileController.selectedImagePath.value;
                  if (newImagePath.isNotEmpty) {
                    // Update profile picture in Firebase
                    await controller.updateProfilePicture(newImagePath);
                    Get.snackbar(
                      'Success',
                      'Profile picture updated successfully!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please select an image first.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Update Profile Picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
