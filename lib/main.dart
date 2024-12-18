import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_pro/publicdashboard/utility/utilitys.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/SignIn.dart';
import 'AlimDashboard/alim_dashboard.dart';  // Alim dashboard
import 'CommonFeatures/CommunityForum/routes/routes.dart';
import 'CommonFeatures/Customs/CustomColor.dart';
import 'CommonFeatures/Customs/navbar.dart';
import 'adminDashboard/admin_dashboard.dart'; // Admin dashboard
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? userRole = prefs.getString('userRole');

  runApp(MyApp(isLoggedIn: isLoggedIn, userRole: userRole));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userRole;

  const MyApp({super.key, required this.isLoggedIn, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: TColors.primary),
          useMaterial3: true,
        ),
      home: _getInitialScreen(),
        getPages: getPages()
    );
  }

  Widget _getInitialScreen() {
    if (isLoggedIn) {
      // Navigate to the dashboard based on the user's role
      if (userRole == 'Alim') {
        return const AlimDashboardMain();  // Alim dashboard screen
      } else if (userRole == 'Public') {
        return const Navigati();       // Public dashboard screen
      } else if (userRole == 'Admin') {
        return const AdminDashboard(); // Admin dashboard screen
      } else {
        // If the role is unknown, show the sign-in screen again
        return const Signin();
      }
    } else {
      // If not logged in, show the sign-in screen
      return const Signin();
    }
  }
}
