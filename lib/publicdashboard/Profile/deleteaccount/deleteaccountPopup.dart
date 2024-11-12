import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Profile/deleteaccount/Authdeleteaccount.dart';
import 'package:get/get.dart';

void deleteAccountWarningPop() {
  Get.defaultDialog(
    backgroundColor: Colors.white,
    contentPadding: const EdgeInsets.all(16),
    title: 'Delete Account',
    middleText: 'Are you sure you want to delete your account permanently?',
    confirm: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the authentication screen
          Get.to(() => DeleteAccountAuthScreen());
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text('Delete'),
        ),
      ),
    ),
    cancel: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text('Cancel'),
        ),
      ),
    ),
  );
}
