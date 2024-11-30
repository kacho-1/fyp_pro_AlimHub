import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as log;
class AddPostController extends GetxController{

  RxBool isImgAvailable = false.obs;
  final _picker = ImagePicker();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxBool isLoading = false.obs;

  late TextEditingController postTxtController;
  CollectionReference userDatBaseReference = FirebaseFirestore.instance.collection("post");


  @override
  void onInit() {
    postTxtController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    postTxtController.dispose();
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }

  Future<String?> uploadImage() async{
    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // first we upload image
    // then we will get download url that we will save in database
    try {
      await storage
          .ref('uploads/post/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      log.log(e.code.toString());
    }

    String downloadURL = await storage
        .ref('uploads/post/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }
  Future<void> addPost({required String userName, required String userUrl}) async {
    // Check if the text is not empty or if an image is available
    if (postTxtController.text.isNotEmpty || isImgAvailable.value) {
      isLoading.value = true;

      // Optional: Handle image upload if available
      String? imageUrl;
      if (isImgAvailable.value && selectedImagePath.value.isNotEmpty) {
        imageUrl = await uploadImage();
      }

      // Use an empty string if no image was uploaded
      String finalUrl = imageUrl ?? '';

      // Save data to the database with the image URL or empty if not present
      await saveDataToDb(
        url: finalUrl, // Will be an empty string if no image was uploaded
        userName: userName,
        userUrl: userUrl,
      );

      // Reset values after successful post
      isLoading.value = false;
      postTxtController.text = '';
      selectedImagePath.value = '';
    } else {
      // Show a warning if both text and image are empty
      Get.snackbar(
        "Warning",
        "Please enter some text or select an image.",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



  /*Future<void> addPost({required String userName, required String userUrl}) async{

    if(isImgAvailable.value && postTxtController.text.isNotEmpty){

      isLoading.value = true;
      uploadImage().then((url){

        if(url != null){

          saveDataToDb(url: url, userName: userName, userUrl: userUrl).then((value){
            isLoading.value = false;

            postTxtController.text = '';
            selectedImagePath.value = '';
          });

        }else{
          isLoading.value = false;
        }
      });

    }else{
      Get.snackbar("Warning", "Please enter details",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20),
          backgroundColor: Colors.red,colorText: Colors.white);
    }
  }*/

  Future<void> saveDataToDb ({
    required String url,
    required String userName,
    required String userUrl }) async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.add({
      'postTitle': postTxtController.text, // add this line in your code
      'userUid': user!.uid,
      'userName': userName,
      'userUrl': userUrl,
      'postUrl': url,
      'time': DateTime.now().millisecondsSinceEpoch,
      'likes' : [],
      'commentsCount' : 0
    });
    return;
  }


/*
class AddPostController extends GetxController{

  RxBool isImgAvailable = false.obs;
  final _picker = ImagePicker();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxBool isLoading = false.obs;

  late TextEditingController postTxtController;
  CollectionReference userDatBaseReference = FirebaseFirestore.instance.collection("post");


  @override
  void onInit() {
    postTxtController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    postTxtController.dispose();
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }

  Future<String?> uploadImage() async{
    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // first we upload image
    // then we will get download url that we will save in database
    try {
      await storage
          .ref('uploads/post/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      log.log(e.code.toString());
    }

    String downloadURL = await storage
        .ref('uploads/post/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }
  Future<void> addPost({
    required String userName,
    required String userUrl,
  }) async {
    // Get user type to determine collection
    String? userCollection = await getUserCollection();

    if (userCollection != null) {
      if (isImgAvailable.value && postTxtController.text.isNotEmpty) {
        isLoading.value = true;
        uploadImage().then((url) {
          if (url != null) {
            saveDataToDb(
              url: url,
              userName: userName,
              userUrl: userUrl,
              userCollection: userCollection, // Pass the collection name
            ).then((value) {
              isLoading.value = false;

              postTxtController.text = '';
              selectedImagePath.value = '';
            });
          } else {
            isLoading.value = false;
          }
        });
      } else {
        Get.snackbar(
          "Warning",
          "Please enter details",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "User type not found.",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  Future<String?> getUserCollection() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Check if the user exists in 'Alim' collection
      DocumentSnapshot alimDoc = await FirebaseFirestore.instance
          .collection('Alim')
          .doc(user.uid)
          .get();

      if (alimDoc.exists) {
        return 'Alim'; // User is an Alim
      }

      // Check if the user exists in 'Public' collection
      DocumentSnapshot publicDoc = await FirebaseFirestore.instance
          .collection('Public')
          .doc(user.uid)
          .get();

      if (publicDoc.exists) {
        return 'Public'; // User is Public
      }
    }

    return null; // If user type is not found
  }
  Future<void> saveDataToDb({
    required String url,
    required String userName,
    required String userUrl,
    required String userCollection, // Use userCollection instead of userType
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference postCollection;

      // Use the correct collection based on userCollection
      if (userCollection == 'Alim') {
        postCollection = FirebaseFirestore.instance.collection('AlimPosts');
      } else {
        postCollection = FirebaseFirestore.instance.collection('PublicPosts');
      }

      // Add post to the appropriate collection
      await postCollection.add({
        'postTitle': postTxtController.text,
        'userUid': user.uid,
        'userName': userName,
        'userUrl': userUrl,
        'postUrl': url,
        'time': DateTime.now().millisecondsSinceEpoch,
        'likes': [],
        'commentsCount': 0
      });
    }
  }
*/




/*Future<void> addPost({required String userName, required String userUrl}) async {
    if (isImgAvailable.value && postTxtController.text.isNotEmpty) {
      isLoading.value = true;

      // Step 1: Fetch user type from Firestore
      String? userType = await getUserType();

      if (userType != null) {
        // Step 2: Upload image and save post
        uploadImage().then((url) {
          if (url != null) {
            saveDataToDb(
                url: url,
                userName: userName,
                userUrl: userUrl,
                userType: userType // Pass userType here
            ).then((value) {
              isLoading.value = false;
              postTxtController.text = '';
              selectedImagePath.value = '';
            });
          } else {
            isLoading.value = false;
          }
        });
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "User type not found",
            snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Warning", "Please enter details",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }*/

// Step 1: Determine user type by checking both collections
  /*Future<String?> getUserType() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Check if the user exists in 'Alim' collection
      DocumentSnapshot alimDoc = await FirebaseFirestore.instance
          .collection('Alim')
          .doc(user.uid)
          .get();

      if (alimDoc.exists) {
        return 'Alim'; // User is an Alim
      }

      // Check if the user exists in 'Public' collection
      DocumentSnapshot publicDoc = await FirebaseFirestore.instance
          .collection('Public')
          .doc(user.uid)
          .get();

      if (publicDoc.exists) {
        return 'Public'; // User is Public
      }
    }

    return null; // If user type is not found
  }

// Step 2: Save post data to the correct collection based on user type
  Future<void> saveDataToDb({
    required String url,
    required String userName,
    required String userUrl,
    required String userType // Add userType here
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference postCollection;

      // Use the correct collection based on userType
      if (userType == 'Alim') {
        postCollection = FirebaseFirestore.instance.collection('AlimPosts');
      } else {
        postCollection = FirebaseFirestore.instance.collection('PublicPosts');
      }

      // Add post to the appropriate collection
      await postCollection.add({
        'postTitle': postTxtController.text,
        'userUid': user.uid,
        'userName': userName,
        'userUrl': userUrl,
        'postUrl': url,
        'userType': userType, // Store the user type
        'time': DateTime.now().millisecondsSinceEpoch,
        'likes': [],
        'commentsCount': 0
      });
    }
  }*/

/* Future<void> addPost({required String userName, required String userUrl,required String userType}) async{

    if(isImgAvailable.value && postTxtController.text.isNotEmpty){

      isLoading.value = true;
      uploadImage().then((url){

        if(url != null){

          saveDataToDb(url: url, userName: userName, userUrl: userUrl,userType: userType).then((value){
            isLoading.value = false;

            postTxtController.text = '';
            selectedImagePath.value = '';
          });

        }else{
          isLoading.value = false;
        }
      });

    }else{
      Get.snackbar("Warning", "Please enter details",
      snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,colorText: Colors.white);
    }
  }

  Future<void> saveDataToDb ({
    required String url,
    required String userName,
    required String userUrl,
    required String userType}) async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.add({
      'postTitle': postTxtController.text, // add this line in your code
      'userUid': user!.uid,
      'userName': userName,
      'userUrl': userUrl,
      'postUrl': url,
      'userType': userType,
      'time': DateTime.now().millisecondsSinceEpoch,
      'likes' : [],
      'commentsCount' : 0
    });
    return;
  }*/

}