import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseScreenlist.dart';

class AlimHubApp extends StatelessWidget {
  const AlimHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlimHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ).copyWith(
          secondary: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.grey[200], // Changed to light grey
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          titleTextStyle: TextStyle(
            fontFamily: 'TimesNewRoman', // Set Times New Roman for AppBar
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'TimesNewRoman', // Set Times New Roman
            fontSize: 16,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'TimesNewRoman', // Set Times New Roman
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'TimesNewRoman', // Set Times New Roman
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      home: CourseListScreen(),
    );
  }
}





