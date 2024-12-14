import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fyp_pro/publicdashboard/setting/screens/FeedbackModel.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

final controller = Get.put(ProfileController());

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  _FeedbackFormScreenState createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final TextEditingController appFeedbackController = TextEditingController();
  final TextEditingController fatwaFeedbackController = TextEditingController();
  final TextEditingController consultancyFeedbackController = TextEditingController();
  final TextEditingController courseFeedbackController = TextEditingController();
  String errorMessage = '';
  String userId = controller.userId;
  String name = controller.name.value;
  String email = controller.email.value;

  @override
  void initState() {
    super.initState();

  }




  // Function to submit the feedback
  Future<void> submitFeedback() async {
    // Check if the user has already submitted feedback
    var feedbackDoc = await FirebaseFirestore.instance
        .collection('feedbacks')
        .doc(userId)
        .get();

    if (feedbackDoc.exists) {
      setState(() {
        errorMessage = 'You have already submitted feedback!';
      });
      return;
    }

    // Create Feedback object
    Feedbacks feedback = Feedbacks(
      userId: userId,
      name: name,
      email: email,
      appFeedback: appFeedbackController.text,
      fatwaFeedback: fatwaFeedbackController.text,
      consultancyFeedback: consultancyFeedbackController.text,
      courseFeedback: courseFeedbackController.text,
      timestamp: DateTime.now(),
    );

    try {
      // Save the feedback to Firestore
      await FirebaseFirestore.instance.collection('feedbacks').doc(userId).set(feedback.toMap());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Feedback submitted successfully!')));
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to submit feedback. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Feedback Form',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              const Text('App Feedback',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),
              TextField(
                controller: appFeedbackController,
                decoration: const InputDecoration(
                  labelText: 'App Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text('Fatwa Feedback',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),
              TextField(
                controller: fatwaFeedbackController,
                decoration: const InputDecoration(
                  labelText: 'Fatwa Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text('Consultancy Feedback',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),
              TextField(
                controller: consultancyFeedbackController,
                decoration: const InputDecoration(
                  labelText: 'Consultancy Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text('Course Feedback',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),
              TextField(
                controller: courseFeedbackController,
                decoration: const InputDecoration(
                  labelText: 'Course Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitFeedback,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: TColors.primary,
                    minimumSize: const Size(200, 50),
                  ),

                  child: const Text('Submit Feedback',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
