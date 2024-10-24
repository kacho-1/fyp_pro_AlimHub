import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  String? imageFilePath;
  String? documentFilePath;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool isAlim = false;  // Track whether "Alim" is selected
  bool isLoading = false;

  // Variables for image picker
  var isImgAvailable = false.obs;
  final _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    qualificationController.dispose();
    addressController.dispose();
    institutionController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    isLoading = true;

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        String uid = userCredential.user!.uid;
        String? imageUrl = await uploadFile();

        if (isAlim) {
          // Store data in 'Alim' collection
          await FirebaseFirestore.instance.collection('Alim').doc(uid).set({
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'qualification': qualificationController.text,
            'address': addressController.text,
            'institution': institutionController.text,
            'experience': experienceController.text,
            'country': selectedCountry,
            'state': selectedState,
            'city': selectedState,
            'imageUrl': imageUrl,
            'createdAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Store data in 'Public' collection
          await FirebaseFirestore.instance.collection('Public').doc(uid).set({
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'imageUrl': imageUrl,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      } on FirebaseAuthException catch (e) {
        // Handle errors
      } finally {
        isLoading = false;
      }
    }
  }

  Future<String?> uploadFile() async {
    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    try {
      await storage.ref('uploads/pic/${randomStr}').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }

    String downloadURL = await storage.ref('uploads/pic/${randomStr}').getDownloadURL();
    return downloadURL;
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }
}
