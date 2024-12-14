import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../Controller/AlimDetailController.dart';

class AddConsultancyDetals extends StatelessWidget {
  AddConsultancyDetals({super.key});

  final AddConsultancyController controller =
  Get.put(AddConsultancyController());

  final TextEditingController aboutController = TextEditingController();  // About text field controller
  final TextEditingController feeController = TextEditingController();  // Fee text field controller
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Experence in Year',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              const SizedBox(height: 16,),
              // New "Specialty" TextField
              TextField(
                controller: experienceController,
                decoration: const InputDecoration(
                  labelText: 'Experience',
                  hintText: 'Enter your Experience',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              const Text('Consultancy Fee',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              // New "Fee" TextField
              const SizedBox(height: 16,),
              TextField(
                controller: feeController,

                decoration: const InputDecoration(
                  labelText: 'Fee',
                  hintText: 'Enter your fee',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // For numeric input
              ),
              const SizedBox(height: 16.0),
              const Text('Speciality Field',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              const SizedBox(height: 16,),
              // New "Specialty" TextField
              TextField(
                controller: specialtyController,
                decoration: const InputDecoration(
                  labelText: 'Specialty Field',
                  hintText: 'Enter your specialty field',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              const Text('About Yourself',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              const SizedBox(height: 16,),
              TextField(
                controller: aboutController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'About',
                  hintText: 'Tell us about yourself',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: TColors.primary,
                    minimumSize: const Size(140, 50),
                  ),
                  onPressed: () {
                    // Save consultancy details
                    controller.saveConsultancyDetails(
                      experience: experienceController.text.trim(),
                      fee: feeController.text.trim(),
                      specialty: specialtyController.text.trim(),
                      about: aboutController.text.trim(),
                    // Pass the Alim UID
                    );
                  },
                  child: const Text('Save',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
