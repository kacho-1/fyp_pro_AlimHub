import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Profile/Controller/UpdatedobController.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeDateOfBirth extends StatelessWidget {
  final UpdateDobrController controller = Get.put(UpdateDobrController());

  ChangeDateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loaddob();
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change Date of Birth',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Please enter your date of birth',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // Form for Date of Birth
            Form(
              key: controller.updateDOBFormKey,
              child: Column(
                children: [
                  Obx(() => TextFormField(
                    controller: controller.dobController.value,
                    style: const TextStyle(fontSize: 14),
                    readOnly: true, // Prevent manual editing
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: Icon(Iconsax.calendar),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900), // Minimum date
                        lastDate: DateTime.now(), // Maximum date
                      );
                      if (pickedDate != null) {
                        controller.setDOB(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  )),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.updateDOBFormKey.currentState?.validate() ?? false) {
                    controller.updateDob();
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
