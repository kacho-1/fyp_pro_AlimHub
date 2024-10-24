import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseCard.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/CourseModel.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/Courses.dart';

class CourseListScreen extends StatelessWidget {
  final List<Course> courses = [
    Course(
      title: 'Learn to Recite Quran in 12 weeks',
      description:
      'Start from the very basics and learn how to recite Quran on your own.',
      level: 'Basic',
      startDate: 'Oct 11, 2024',
      instructor: 'Sheikh Abdullah',
      article:
      'Reciting the Quran is an integral part of a Muslim’s life. In this course, we start with the basics, teaching students the correct pronunciation of Arabic letters. We gradually move on to simple verses, and by the end of 12 weeks, you’ll be able to recite entire chapters confidently. Regular practice is essential, and you’ll be provided with resources to practice daily. Join us and develop a lifelong connection with the Holy Quran.',
    ),
    Course(
      title: 'Master your Tajweed in 4 months',
      description:
      'Enhance your fluency and achieve perfection with expert-led learning.',
      level: 'Advanced',
      startDate: 'Oct 18, 2024',
      instructor: 'Mufti Saeed',
      article:
      'Tajweed is the science of reciting the Quran with proper pronunciation, tone, and rhythm. This course will help you perfect your recitation, emphasizing the nuances of each letter and sound. Through detailed lessons, you will understand how to apply the rules of Tajweed to achieve fluency. You will also be tested on various surahs to ensure your skills meet the standards set by scholars. Master Tajweed with us and elevate your Quranic recitation to the next level.',
    ),
    Course(
      title: 'Islamic History Crash Course',
      description: 'Learn key events and figures in Islamic history.',
      level: 'Intermediate',
      startDate: 'Nov 1, 2024',
      instructor: 'Dr. Bilal',
      article:
      'Islamic history spans over 1400 years and is filled with important events that shaped the world. In this course, we cover the life of the Prophet Muhammad (PBUH), the expansion of the Islamic empire, and key dynasties such as the Umayyads and Abbasids. We will explore the contributions of Islamic scholars to science, philosophy, and culture. By the end of this course, you will have a deep understanding of how Islamic history has influenced the modern world.',
    ),
    Course(
      title: 'Understanding Fiqh',
      description: 'A deep dive into Islamic jurisprudence and rulings.',
      level: 'Advanced',
      startDate: 'Oct 25, 2024',
      instructor: 'Mufti Ahmed',
      article:
      'Fiqh is the understanding of Islamic rulings derived from the Quran and Sunnah. In this course, we will study the four main schools of thought (Hanafi, Shafi’i, Maliki, and Hanbali) and their differences in interpretation. You will learn about topics such as purification, prayer, fasting, and zakat. This course is ideal for students seeking an in-depth knowledge of Islamic jurisprudence and its practical application in daily life.',
    ),
    Course(
      title: 'Daily Duas and Their Meanings',
      description: 'Learn important duas and their applications in daily life.',
      level: 'Basic',
      startDate: 'Oct 15, 2024',
      instructor: 'Sheikh Omar',
      article:
      'Duas, or supplications, are a powerful way to connect with Allah. In this course, you will learn the meaning and significance of essential daily duas, such as those for morning and evening, before meals, and during difficult times. We will also teach the correct pronunciation and provide tips on incorporating these duas into your daily routine. Strengthen your spiritual life by mastering the duas that can bring peace and blessings into your life.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Islamic Courses',
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}