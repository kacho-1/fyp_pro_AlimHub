import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseModel.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructor: ${course.instructor}',
                style: const TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Start Date: ${course.startDate}',
                style: const TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Course Details',
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.article,
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Enroll action can be handled here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Confirm Enrollment',style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
