import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Privacy Policy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Privacy Policy for AlimHub',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Effective Date: December 2024',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const Text(
              'At AlimHub, we are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy applies to all users of the AlimHub mobile application ("the App"), which is offered by SEERAHT International. By using the App, you agree to the collection and use of information as outlined in this Privacy Policy.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('1. Introduction'),
            _buildParagraph(
              'AlimHub is a mobile application that offers a centralized platform for users in Pakistan to access trustworthy Islamic counsel from competent Ulamas of the Ahle-e-Sunnah Wal Jamaah sect. The App facilitates communication, consultations, advice, posing queries, video conferences, fatwas, Islamic courses, webinars, and workshops. SEERAHT International ensures the verification of Ulamas to maintain the quality and reliability of the services.',
            ),
            _buildSectionTitle('2. Information We Collect'),
            _buildParagraph(
              'To provide personalized services, the following information may be collected from users:\n\n'
                  'a. Personal Information:\n'
                  '• Full Name\n'
                  '• Email Address\n'
                  '• Phone Number\n'
                  '• Profile Picture (optional)\n'
                  '• Location (for location-based services)\n\n'
                  'b. Usage Data:\n'
                  '• Device Information: such as device type, operating system, and IP address.\n'
                  '• Log Data: details about your use of the App, including timestamps, interactions, and activity within the app.\n\n'
                  'c. Consultation Data:\n'
                  '• Queries or questions submitted through the app.\n'
                  '• Consultation preferences, such as category (General inquiries, Dream interpretation, Spiritual advice).\n'
                  '• Session records and feedback provided after consultations or video conferences.\n\n'
                  'd. Communication Information:\n'
                  '• Emails or messages exchanged with the App’s support or Ulamas.',
            ),
            _buildSectionTitle('3. How We Use Your Information'),
            _buildParagraph(
              'We use the collected information for the following purposes:\n\n'
                  '• To provide services: such as connecting users with Ulamas, scheduling consultations, and facilitating video calls or fatwas.\n'
                  '• To improve user experience: ensuring a personalized experience by analyzing user preferences and activity.\n'
                  '• To manage accounts: including user authentication and profile management.\n'
                  '• To notify you: about upcoming courses, webinars, consultations, or any other relevant updates.\n'
                  '• To ensure safety and security: to prevent fraud or misuse of the platform.\n'
                  '• To communicate with you: responding to inquiries, feedback, or providing support.',
            ),
            _buildSectionTitle('4. How We Share Your Information'),
            _buildParagraph(
              'We respect your privacy and will not sell or rent your personal information to third parties. However, your information may be shared under the following circumstances:\n\n'
                  '• With Ulamas: Information related to consultations, including queries, session feedback, and consultation categories, may be shared with the relevant Ulama to provide guidance.\n'
                  '• With third-party service providers: We may share necessary information with trusted partners who assist us in the operation and maintenance of the App, such as hosting services or payment processors.\n'
                  '• Legal Compliance: We may disclose information if required to do so by law or if we believe such action is necessary to comply with legal obligations, protect our rights, or prevent fraud.',
            ),
            _buildSectionTitle('5. Data Retention'),
            _buildParagraph(
              'We retain your personal data only for as long as necessary to fulfill the purposes outlined in this Privacy Policy or as required by law. If you wish to delete your data, you can request account deletion through the app settings, after which we will delete your information in accordance with applicable laws.',
            ),
            _buildSectionTitle('6. Security of Your Information'),
            _buildParagraph(
              'We use commercially reasonable means to protect your personal information from unauthorized access, use, or disclosure. This includes encryption during data transmission and access controls to prevent unauthorized personnel from viewing your data.',
            ),
            _buildSectionTitle('7. Your Rights'),
            _buildParagraph(
              'You have the right to:\n\n'
                  '• Access and update your information: You can update your profile and account information at any time.\n'
                  '• Request deletion: You may request the deletion of your account and associated data by contacting our support team.\n'
                  '• Withdraw consent: You can withdraw consent for the use of your personal data for certain purposes by changing your settings or contacting us directly.',
            ),
            _buildSectionTitle('8. Children’s Privacy'),
            _buildParagraph(
              'AlimHub is not intended for users under the age of 13. We do not knowingly collect personal data from children under 13. If we become aware that a child under 13 has provided personal information, we will take steps to delete such information.',
            ),
            _buildSectionTitle('9. Changes to This Privacy Policy'),
            _buildParagraph(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify users of any significant changes by posting the updated Privacy Policy in the app or via email.',
            ),
            _buildSectionTitle('10. Contact Us'),
            _buildParagraph(
              'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n\n'
                  'Email: support@alimhub.com\n'
                  'Phone: +92 123 456 7890',
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
