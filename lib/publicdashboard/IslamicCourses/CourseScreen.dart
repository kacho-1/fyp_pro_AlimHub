import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseModel.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

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
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Start Date: ${course.startDate}',
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Course Details',
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                course.article,
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Enroll action can be handled here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Confirm Enrollment',style: TextStyle(
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
