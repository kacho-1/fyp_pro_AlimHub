import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/alimbookingpage.dart';
import 'consultancytypecard.dart';

class ConsultationTypePage extends StatefulWidget {
  final String alimUid;

  const ConsultationTypePage({super.key, required this.alimUid});

  @override
  State<ConsultationTypePage> createState() => _ConsultationTypePageState();
}

class _ConsultationTypePageState extends State<ConsultationTypePage> {
  var alimData = {}.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchAlimData();
  }

  // Fetch Alim data based on alimUid
  Future<void> _fetchAlimData() async {
    try {
      var alimSnapshot = await _firestore
          .collection('alim_availability')
          .doc(widget.alimUid)
          .get();

      if (alimSnapshot.exists) {
        alimData.value = alimSnapshot.data()!;
      }
    } catch (e) {
      print('Error fetching Alim data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Consultation Type')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ConsultationTypeCard(
              title: "Text-Based Consultation",
              description: "Submit your queries and get a written response.",
              icon: Icons.message,
              onPressed: () {
                Get.to(() => AlimBookingPage(alimData: alimData['alimUid'], ConsultancyType: 'Text-Based',));
              },
            ),
            const SizedBox(height: 25),
            ConsultationTypeCard(
              title: "Video Call Consultation",
              description: "Schedule a video call with a scholar.",
              icon: Icons.video_call,
              onPressed: () {
                Get.to(() => AlimBookingPage(alimData: alimData['alimUid'], ConsultancyType: 'Video-call',));
              },
            ),
          ],
        ),
      ),
    );
  }
}
