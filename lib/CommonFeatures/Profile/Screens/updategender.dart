import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../Controller/UpdateGenderController.dart';

class ChangeGender extends StatelessWidget {
  final UpdateGenderController controller = Get.put(UpdateGenderController());

  ChangeGender({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadGenderDetail();
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change Gender',
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
              'Please select your gender',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // Form for Gender Selection
            Form(
              key: controller.updateGenderFormKey,
              child: Column(
                children: [
                  Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedGender.value.isNotEmpty
                        ? controller.selectedGender.value
                        : null,
                    items: controller.genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: Icon(Iconsax.profile_circle),
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectedGender.value = newValue;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
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
                  if (controller.updateGenderFormKey.currentState?.validate() ?? false) {
                    controller.updateGender();
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
