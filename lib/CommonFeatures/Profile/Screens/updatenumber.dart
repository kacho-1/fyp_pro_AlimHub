import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../Controller/UpdatephoneController.dart';
class ChangePhoneNumber extends StatelessWidget {
  final UpdatePhoneNumberController controller = Get.put(UpdatePhoneNumberController());

  ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadPhoneNumber();
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change Phone Number',
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
              'Please enter a valid Phone Number',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // Text Fields
            Form(
              key: controller.updatePhoneNumberFormKey,
              child: Column(
                children: [
                  Obx(() => TextFormField(
                    controller: controller.phoneController.value,
                    style: const TextStyle(fontSize: 14),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Iconsax.call),
                    ),
                    validator: (value) {
                      String pattern = r'^03\d{9}$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!regex.hasMatch(value)) {
                        return 'Enter a valid  phone number ';
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
                  if (controller.updatePhoneNumberFormKey.currentState?.validate() ?? false) {
                    controller.updatePhoneNumber();
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
