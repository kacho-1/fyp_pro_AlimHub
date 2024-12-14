import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('FAQ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('1. What is AlimHub?'),
            _buildParagraph(
              'AlimHub is a mobile application developed by SEERAHT International that provides a centralized platform for users in Pakistan to access trustworthy Islamic counsel from competent Ulamas of the Ahle-e-Sunnah Wal Jamaah sect. The app facilitates communication, consultations, video conferences, fatwas, Islamic courses, webinars, and workshops.',
            ),
            _buildSectionTitle('2. What services does AlimHub offer?'),
            _buildParagraph(
              'AlimHub offers a wide range of services, including:\n\n'
                  '• Consultation with verified Ulamas on general inquiries, dream interpretation, spiritual advice, and more.\n'
                  '• Video conferences with Ulamas for face-to-face consultations.\n'
                  '• Access to Islamic courses, webinars, and workshops.\n'
                  '• Fatwas on various Islamic topics.\n'
                  '• A platform to ask questions and receive answers from knowledgeable scholars.\n'
                  '• A secure and private environment for all consultations.',
            ),
            _buildSectionTitle('3. How do I get started with AlimHub?'),
            _buildParagraph(
              'To get started with AlimHub, follow these simple steps:\n\n'
                  '1. Download the AlimHub app from the App Store or Google Play Store.\n'
                  '2. Create a user account by providing necessary details such as name, email, and phone number.\n'
                  '3. Choose your consultation category (e.g., general inquiries, dream interpretation, spiritual advice).\n'
                  '4. Browse through available Ulamas and select a scholar for your consultation.\n'
                  '5. Schedule a session or start a live video consultation with the selected Ulama.',
            ),
            _buildSectionTitle('4. Are the Ulamas on AlimHub verified?'),
            _buildParagraph(
              'Yes, all Ulamas on AlimHub are verified by SEERAHT International. We ensure that only competent and trustworthy scholars from the Ahle-e-Sunnah Wal Jamaah sect are part of the platform. Their qualifications, expertise, and knowledge are thoroughly validated to ensure users receive accurate and reliable Islamic guidance.',
            ),
            _buildSectionTitle('5. What consultation categories are available on AlimHub?'),
            _buildParagraph(
              'AlimHub offers various consultation categories to address the diverse needs of users, including:\n\n'
                  '• General inquiries about Islam\n'
                  '• Dream interpretation\n'
                  '• Spiritual advice and guidance\n'
                  '• Fatwas on specific issues\n\n'
                  'Each category is handled by qualified Ulamas with expertise in those fields.',
            ),
            _buildSectionTitle('6. Can I ask questions without booking a video consultation?'),
            _buildParagraph(
              'Yes, you can submit questions to Ulamas via the app, and they will respond with answers or guidance. You do not have to book a video consultation to ask a question. However, if you prefer a more personalized and direct interaction, you can schedule a video call with an Ulama.',
            ),
            _buildSectionTitle('7. Is the information shared in consultations confidential?'),
            _buildParagraph(
              'Yes, the information shared during consultations is private and confidential. AlimHub prioritizes user privacy and ensures that all communications, including video consultations and text-based queries, are secure and protected.',
            ),
            _buildSectionTitle('8. How do I schedule a video consultation?'),
            _buildParagraph(
              'To schedule a video consultation on AlimHub, follow these steps:\n\n'
                  '1. Open the app and browse available Ulamas.\n'
                  '2. Select a scholar based on your preferred consultation category.\n'
                  '3. Choose a time slot for the consultation.\n'
                  '4. Confirm the booking and await the Ulama’s confirmation.\n'
                  '5. Join the scheduled video session at the designated time.',
            ),
            _buildSectionTitle('9. How do I access Islamic courses and webinars?'),
            _buildParagraph(
              'To access Islamic courses and webinars on AlimHub, navigate to the "Courses" section in the app. You will find a list of available courses and upcoming webinars. You can register for free or paid courses depending on availability. Notifications will be sent for upcoming webinars.',
            ),
            _buildSectionTitle('10. How do I provide feedback about a consultation?'),
            _buildParagraph(
              'After each consultation, you will have the opportunity to provide feedback on your experience. You can rate the session and the Ulama based on your satisfaction. Your feedback helps us improve the platform and ensures the quality of services offered.',
            ),
            _buildSectionTitle('11. Can I delete my account on AlimHub?'),
            _buildParagraph(
              'Yes, you can delete your account by going to the "Settings" section of the app. If you wish to delete your account, follow the prompts, and all your personal information will be removed from our platform. Please note that this action is irreversible.',
            ),
            _buildSectionTitle('12. How can I contact customer support?'),
            _buildParagraph(
              'If you have any questions or issues, you can contact our customer support team at any time. Visit the "Support" section of the app to get in touch with us via email or phone.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),


      ),
    );
  }

  Widget _buildParagraph(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
