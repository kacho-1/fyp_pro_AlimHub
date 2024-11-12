import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  String get userId {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
  var isImgAvailable = false.obs;
  final _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Observable variables to hold user data
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString dob = ''.obs;
  RxString gender = ''.obs;
  RxString username = ''.obs;
  RxString imageUrl = ''.obs;

  // Get the currently authenticated user
  User? user = FirebaseAuth.instance.currentUser;

  // Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // Initialize the listener for real-time updates
    _initializeListener();
  }

  // Initialize Firestore listener for real-time updates
  void _initializeListener() {
    if (user != null) {
      // Listen to changes in both the 'Alim' and 'Public' collections
      _firestore.collection('Public').doc(user!.uid).snapshots().listen((
          snapshot) {
        if (snapshot.exists) {
          _updateUserData(snapshot);
        }
      });
    }
  }

  // Helper method to update user data from the Firestore snapshot
  void _updateUserData(DocumentSnapshot snapshot) {
    name.value = snapshot['name'] ?? '';
    email.value = snapshot['email'] ?? '';
    phone.value = snapshot['phone'] ?? '';
    dob.value = snapshot['dob'] ?? '';
    gender.value = snapshot['gender'] ?? '';
    username.value = snapshot['username'] ?? '';
    imageUrl.value = snapshot['imageUrl'] ?? '';
  }

  // Method to fetch initial user data manually if needed
  Future<void> getUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot;

        // If not found in 'Alim', check in 'Public'
        documentSnapshot =
        await _firestore.collection('Public').doc(user!.uid).get();

        // Update user data from the document snapshot
        if (documentSnapshot.exists) {
          name.value = documentSnapshot['name'] ?? '';
          email.value = documentSnapshot['email'] ?? '';
          imageUrl.value = documentSnapshot['imageUrl'] ?? '';
          dob.value = documentSnapshot['dob'] ?? '';
          username.value = documentSnapshot ['username'] ?? '';
          gender.value = documentSnapshot ['gender'] ?? '';
          phone.value = documentSnapshot['phone'] ?? '';
          _updateUserData(documentSnapshot);
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
  Future<String?> uploadFile() async {
    // Ensure that the selectedImagePath is not null and valid
    if (selectedImagePath.value == null || selectedImagePath.value.isEmpty) {
      print('No image selected.');
      return null; // Return null if there's no image
    }

    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    // Generate a random string for the file name to avoid conflicts
    /* const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
*/
    // Upload the image to Firebase Storage
    try {
      // Use the random string as part of the file name
      await storage.ref('uploads/pic/$userId').putFile(file);

      // Get the download URL for the uploaded file
      String downloadURL = await storage.ref('uploads/pic/$userId').getDownloadURL();

      return downloadURL; // Return the download URL
    } on FirebaseException catch (e) {
      // Handle specific Firebase exceptions
      print('Error during file upload: ${e.code}');
      return null; // Return null if an error occurs
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: $e');
      return null; // Return null for any other errors
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }






/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
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

*/
}
