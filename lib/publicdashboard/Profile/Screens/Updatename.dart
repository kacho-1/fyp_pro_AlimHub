import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Controller/Updatenamecontroller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20,),

            // Text Fields
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    style: const TextStyle(fontSize: 14),
                    expands: false,
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
            SizedBox(height:10,),

            // Save Button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () =>  controller.updateUserName(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
