import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
        title: Text('Add Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Experence in Year',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              SizedBox(height: 16,),
              // New "Specialty" TextField
              TextField(
                controller: experienceController,
                decoration: InputDecoration(
                  labelText: 'Experience',
                  hintText: 'Enter your Experience',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16,),
              Text('Consultancy Fee',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              // New "Fee" TextField
              SizedBox(height: 16,),
              TextField(
                controller: feeController,

                decoration: InputDecoration(
                  labelText: 'Fee',
                  hintText: 'Enter your fee',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // For numeric input
              ),
              SizedBox(height: 16.0),
              Text('Speciality Field',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              SizedBox(height: 16,),
              // New "Specialty" TextField
              TextField(
                controller: specialtyController,
                decoration: InputDecoration(
                  labelText: 'Specialty Field',
                  hintText: 'Enter your specialty field',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16,),
              Text('About Yourself',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
              // New "Fee" TextField
              SizedBox(height: 16,),
              TextField(
                controller: aboutController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'About',
                  hintText: 'Tell us about yourself',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: TColors.primary,
                    minimumSize: Size(140, 50),
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
                  child: Text('Save',
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
