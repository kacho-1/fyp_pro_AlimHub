import 'package:cloud_firestore/cloud_firestore.dart';

class Feedbacks {
  String userId;
  String name;
  String email;
  String appFeedback;
  String fatwaFeedback;
  String consultancyFeedback;
  String courseFeedback;
  DateTime timestamp;

  Feedbacks({
    required this.userId,
    required this.name,
    required this.email,
    required this.appFeedback,
    required this.fatwaFeedback,
    required this.consultancyFeedback,
    required this.courseFeedback,
    required this.timestamp,
  });

  // Convert Feedback to Map for saving in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'appFeedback': appFeedback,
      'fatwaFeedback': fatwaFeedback,
      'consultancyFeedback': consultancyFeedback,
      'courseFeedback': courseFeedback,
      'timestamp': timestamp,
    };
  }

  // Create Feedback from Firestore data
  factory Feedbacks.fromMap(Map<String, dynamic> map) {
    return Feedbacks(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      appFeedback: map['appFeedback'],
      fatwaFeedback: map['fatwaFeedback'],
      consultancyFeedback: map['consultancyFeedback'],
      courseFeedback: map['courseFeedback'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
