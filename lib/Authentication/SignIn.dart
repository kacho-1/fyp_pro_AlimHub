import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AlimDashboard/alim_dashboard.dart';
import '../CommonFeatures/Customs/navbar.dart';
import '../adminDashboard/admin_dashboard.dart';
import 'SignUp.dart';
import 'package:fyp_pro/Authentication/forgetpassword.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPressed = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetLink(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInUserWithEmailAndPassword() async {
    if (_formKey.currentState!
        .validate()) { // Validate email and password on client side
      try {
        // Try Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Signed In')),
        );

        // Get the user's UID and check role
        String uid = userCredential.user!.uid;
        await _checkUserRole(uid);
        // Save login state in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        // Get the user role from Firestore and store it
        DocumentSnapshot alimSnapshot =
        await FirebaseFirestore.instance.collection('Alim').doc(uid).get();

        if (alimSnapshot.exists) {
          prefs.setString('userRole', 'Alim');
        } else {
          DocumentSnapshot publicSnapshot =
          await FirebaseFirestore.instance.collection('Public').doc(uid).get();

          if (publicSnapshot.exists) {
            prefs.setString('userRole', 'Public');
          } else {
            DocumentSnapshot adminSnapshot =
            await FirebaseFirestore.instance.collection('Admin').doc(uid).get();

            if (adminSnapshot.exists) {
              prefs.setString('userRole', 'Admin');
            }
          }
        }


      } on FirebaseAuthException catch (e) {
        // Handle Firebase-specific errors
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No account found with this email address.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'This account has been disabled.';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Too many login attempts. Please try again later.';
        } else {
          errorMessage = 'An unexpected error occurred: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An unexpected error occurred. Please try again.')),
        );
      }
    }
  }


  /*Future<void> _signInUserWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Proceed with sign-in using Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Signed In')),
        );

        // Get the user's UID
        String uid = userCredential.user!.uid;

        // Check the user's role in Firestore and navigate accordingly
        await _checkUserRole(uid);
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'wrong-password':
            message = 'Wrong password provided.';
            break;
          case 'user-not-found':
            message = 'No user found for that email.';
            break;
          case 'user-disabled':
            message = 'This user has been disabled.';
            break;
          case 'too-many-requests':
            message = 'Too many requests. Try again later.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        print('Error: $e');
      }
    }
  }*/

  Future<void> _checkUserRole(String uid) async {
    try {
      // Check if the user exists in the Alim collection
      DocumentSnapshot alimSnapshot =
      await FirebaseFirestore.instance.collection('Alim').doc(uid).get();

      if (alimSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AlimDashboardMain()),
        );
        return; // Exit after navigation
      }

      // Check if the user exists in the Public collection
      DocumentSnapshot publicSnapshot =
      await FirebaseFirestore.instance.collection('Public').doc(uid).get();

      if (publicSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigati()),
        );
        return; // Exit after navigation
      }

      // Check if the user exists in the Admin collection
      DocumentSnapshot adminSnapshot =
      await FirebaseFirestore.instance.collection('Admin').doc(uid).get();

      if (adminSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        return; // Exit after navigation
      }
      else {
        print('User data not found!');
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 190,
                        height: 170,
                        child: Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.08),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'AlimHub',
                        style: TextStyle(
                          fontSize: 24,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Colors.black,
                                Colors.grey.shade700
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(Rect.fromLTWH(
                                0, 0, screenWidth * 0.5, screenHeight * 0.05)),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.09),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome To AlimHub! \n ',
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: <Color>[
                                      Colors.black,
                                      Colors.grey.shade800
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, screenWidth * 0.5,
                                      screenHeight * 0.05)),
                              ),
                            ),
                            TextSpan(
                              text: 'Please Enter Email and Password ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: <Color>[
                                      Colors.black,
                                      Colors.grey.shade700
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, screenWidth * 0.5,
                                      screenHeight * 0.05)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      _buildTextFormField(
                        controller: _emailController,
                        hintText: 'Enter Your Email',
                        labelText: 'Email',
                        icon: Icons.mail_outline_sharp,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      _buildTextFormField(
                        controller: _passwordController,
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                    forgetpassword()));
                              },
                              child: Text("Forget Password?"))),
                      SizedBox(height: screenHeight * 0.10),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPressed = !_isPressed;
                          });
                          _signInUserWithEmailAndPassword();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.white,
                                Colors.grey.shade400
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.3,
                                  vertical: screenHeight * 0.020),
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isPressed = !_isPressed;
                                });
                                _signInUserWithEmailAndPassword();
                              }
                            },
                            child: const Text('Sign In', style: TextStyle(
                                fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => Signup()));
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: "Don't have an Account? ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: 'Sign Up!',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
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

