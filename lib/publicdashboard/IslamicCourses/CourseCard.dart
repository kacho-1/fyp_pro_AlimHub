import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseModel.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseScreen.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  course.title,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman', // Times New Roman
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailScreen(course: course),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Enroll",style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            course.description,
            style: TextStyle(
              fontFamily: 'TimesNewRoman', // Times New Roman
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: course.level == "Basic"
                      ? Colors.green
                      : course.level == "Intermediate"
                      ? Colors.orange
                      : Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  course.level,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman', // Times New Roman
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                course.startDate,
                style: TextStyle(
                  fontFamily: 'TimesNewRoman', // Times New Roman
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
