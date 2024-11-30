import 'package:flutter/material.dart';
import '../Screens/alimbookingpage.dart';
import 'consultancytypecard.dart';


class ConsultationTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Consultation Type')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            ConsultationTypeCard(
              title: "Text-Based Consultation",
              description: "Submit your queries and get a written response.",
              icon: Icons.message,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const AlimBookingPage()));
              },
            ),
            SizedBox(height: 25),
            ConsultationTypeCard(
              title: "Video Call Consultation",
              description: "Schedule a video call with a scholar.",
              icon: Icons.video_call,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>AlimBookingPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
