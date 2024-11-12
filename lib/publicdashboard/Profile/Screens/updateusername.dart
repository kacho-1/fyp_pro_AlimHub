import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../Controller/UpdateUsernamecontroller.dart';


class ChangeUserName extends StatelessWidget {
  final UpdateUserNameController controller = Get.put(UpdateUserNameController());

  ChangeUserName({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadUserName();
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change UserName', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Enter your username. This not show anywhere in the app',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20,),

            // Text Fields
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  Obx(()=> TextFormField(
                    controller: controller.usernameController.value,
                    style: const TextStyle(fontSize: 14),
                    expands: false,
                    decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Iconsax.user)),
                  ),

                  )],
              ),
            ),
            SizedBox(height:10,),

            // Save Button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () {
                controller.updateUserName();

              }, child: const Text('Save')),
            ),


          ],
        ),
      ),
    );
  }

}
