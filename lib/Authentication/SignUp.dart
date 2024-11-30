import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/Authentication/SignIn.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../CommonFeatures/Profile/Controller/Profilecontroller.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}


class _SignupState extends State<Signup> {
  final profilecontroller = ProfileController();
  XFile? image;
  UploadTask? uploadtask;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _username =TextEditingController();
  String?  selectedcountry;
  String?  selectedstate;
  String? selectedcity;
  bool _isAlim = false;  // Track whether "Alim" is selected
  bool _isLoading = false;
  var isLoading = false.obs;

  //var isImgAvailable = false.obs;
  final _picker = ImagePicker();
  //var selectedImagePath = ''.obs;
  //var selectedImageSize = ''.obs;



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _qualificationController.dispose();
    _addressController.dispose();
    _institutionController.dispose();
    _experienceController.dispose();
    _username.dispose();
    _dob.dispose();
    _gender.dispose();
    super.dispose();
  }


  Future<void> _createUserWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });


    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,

        );
        String uid = userCredential.user!.uid;
        String? imageUrl = await profilecontroller.uploadFile();

        if (_isAlim) {
          // Store data in 'Alim' collection
          await FirebaseFirestore.instance.collection('Alim').doc(uid).set({
            'name': _nameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
            'qualification': _qualificationController.text,
            'address': _addressController.text,
            'institution': _institutionController.text,
            'experience': _experienceController.text,
            'country': selectedcountry,
            'state': selectedstate,
            'city': selectedstate,
            'imageUrl': imageUrl,
            'username': _username.text,
            'dob' :_dob.text,
            'gender': _gender.text,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        else {
          // Store data in 'Public' collection
          await FirebaseFirestore.instance.collection('Public').doc(uid).set({
            'name' : _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'imageUrl': imageUrl,
            'username': _username.text,
            'dob' :_dob.text,
            'gender': _gender.text,
            'phone': _phoneController.text,

            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Signed Up')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Signin()),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            message = 'The account already exists for that email.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  Widget _buildPictureUploadButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              profilecontroller.getImage(ImageSource.gallery);
            },
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Obx(
                      () => profilecontroller.selectedImagePath.value == ''
                      ? const CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ))
                      : CircleAvatar(
                    radius: 80,
                    backgroundImage: Image.file(
                      File(profilecontroller.selectedImagePath.value),
                      fit: BoxFit.fill,
                    ).image,
                  ),
                ),
              ),
            ),
          )]);
  }
  Widget _countryPicker(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 0.0),
          child: Card(
            shape: RoundedRectangleBorder(


            ),
            //elevation: 10.0,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 0.0),
                child:CSCPicker(
                  layout: Layout.vertical,
                  flagState: CountryFlag.ENABLE,
                  onCountryChanged: (country){
                    selectedcountry = country;
                    print(country);
                  },
                  onStateChanged: (state){
                    selectedstate =state;
                    print(state);
                  },
                  onCityChanged: (city){
                    selectedcity = city;
                    print(city);
                  },
                  countrySearchPlaceholder: 'Country',
                  stateSearchPlaceholder: 'State',
                  citySearchPlaceholder: 'City',
                  countryDropdownLabel: 'Select the Country',
                  stateDropdownLabel: 'Select the State',
                  cityDropdownLabel: 'Select the City',
                  dropdownDialogRadius: 12,
                  searchBarRadius: 30,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: Colors.grey,
                    border: Border.all(color: Colors.white,width: 2),

                  ),
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: Colors.grey.shade500,
                    border: Border.all(color: Colors.white,width: 2),
                  ),
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                ) ),

          ),
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.green.shade800,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jfif'),
              fit: BoxFit.cover, // Adjust the image to cover the entire screen
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),

                          _buildPictureUploadButton(),
                          SizedBox(height: screenHeight * 0.04),

                          // Toggle buttons for user type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlim = false;
                                  });
                                },
                                child: Text(
                                  'Public',
                                  style: TextStyle(
                                    color: _isAlim ? Colors.black : Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isAlim = true;
                                  });
                                },
                                child: Text(
                                  'Alim',
                                  style: TextStyle(
                                    color: _isAlim ? Colors.black : Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: screenHeight * 0.03),

                          // Basic fields for both "Public" and "Alim"
                          _buildTextFormField(
                            controller: _emailController,
                            hintText: 'Enter Your Email',
                            labelText: 'Email',
                            icon: Icons.mail_outline_sharp,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          _buildTextFormField(
                            controller: _nameController,
                            hintText: 'Enter Your Name',
                            labelText: 'Name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          _buildTextFormField(
                            controller: _passwordController,
                            hintText: 'Enter Your Password',
                            labelText: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (value) {
                              if (value==null || value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              if(!value.contains(RegExp(r'[A-Z]'))){
                                return 'Password Must Contain at least one Upper Letter';
                              }
                              if(!value.contains(RegExp(r'[0-9]'))){
                                return 'Password Must Contain at least one number';
                              }
                              if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
                                return 'Password Must Contain alleast one special character';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          _buildTextFormField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),



                          // Additional fields if "Alim" is selected
                          if (_isAlim) ...[
                            SizedBox(height: screenHeight * 0.04),
                            _buildTextFormField(
                              controller: _phoneController,
                              hintText: 'Enter Your Phone Number',
                              labelText: 'Phone',
                              icon: Icons.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Phone Number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            _buildTextFormField(
                              controller: _qualificationController,
                              hintText: 'Enter Your Qualification',
                              labelText: 'Qualification',
                              icon: Icons.school,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Qualification';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            _buildTextFormField(
                              controller: _addressController,
                              hintText: 'Enter Your Address',
                              labelText: 'Address',
                              icon: Icons.location_on,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            _buildTextFormField(
                              controller: _institutionController,
                              hintText: 'Enter Studied Institution',
                              labelText: 'Studied Institution',
                              icon: Icons.business,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Institution';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            _buildTextFormField(
                              controller: _experienceController,
                              hintText: 'Enter Your Experience',
                              labelText: 'Experience',
                              icon: Icons.work,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Experience';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            _countryPicker(),
                            /*
                            SizedBox(height: screenHeight * 0.04),
                            _buildDocumentUploadButton(),*/
                          ],

                          SizedBox(height: screenHeight * 0.08),
                          _buildSignUpButton(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.02),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(

                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Signin()),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(text: "Don't have an Account? ", style: TextStyle(color: Colors.black,)),
                                    TextSpan(text: 'Sign Up!',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Sign Up button
  Widget _buildSignUpButton(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        _createUserWithEmailAndPassword();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: <Color>[Colors.white, Colors.grey.shade400],
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.3, vertical: screenHeight * 0.020),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _createUserWithEmailAndPassword();
            }
          },
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.black)
              : Text('Sign Up', style: TextStyle(fontSize: 22, color: Colors.black)),

        ),
      ),

    );

  }

  // Build text form field widget
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
        filled: true,
        fillColor: Colors.grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

}

