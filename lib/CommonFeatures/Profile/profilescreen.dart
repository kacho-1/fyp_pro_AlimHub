import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../Customs/CustomColor.dart';
import '../Customs/CustomProfile.dart';
import '../Customs/customSettingsection.dart';
import 'Controller/Profilecontroller.dart';
import 'Screens/Updatename.dart';
import 'Screens/updatedob.dart';
import 'Screens/updategender.dart';
import 'Screens/updatenumber.dart';
import 'Screens/updateprofilepicture.dart';
import 'Screens/updateusername.dart';
import 'deleteaccount/deleteaccountPopup.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Profile',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
        backgroundColor: TColors.primary,
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Obx(()=>Column(
                  children: [
                  Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 80-12*2,
                        width: 80-12*2,
                        fit: BoxFit.cover,
                        imageUrl: controller.imageUrl.value,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/my.png'),
                      ),
                    ),

                  ),
                    TextButton(onPressed: (){
                     Get.to(()=>ChangeProfilePictureScreen());
                    },
                        child: const Text('Change Profile Picture')),

                    ],
                ),
                ),
              ),
              const SizedBox(height: 8,),
              const Divider(),
              const SizedBox(height: 16,),
              const TSectionsetting(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: 16,),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(() =>  ChangeName()), title: 'Name', value: controller.name.value),),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(() =>  ChangeUserName()), title: 'UserName', value: controller.username.value)),
              const SizedBox(height: 16,),
              const Divider(),
              const SizedBox(height: 16,),
              
              const TSectionsetting(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: 16,),
              TProfileMenu(onPressed: ()=>copyToClipboard(controller.userId), title: 'UserId', value: controller.userId,icon: Iconsax.copy,),
              TProfileMenu(onPressed: ()=>copyToClipboard(controller.email.value), title: 'Email', value: controller.email.value,icon: Iconsax.copy),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(()=>ChangePhoneNumber()), title: 'Phone', value: controller.phone.value)),
              Obx(()=> TProfileMenu(onPressed: ()=> Get.to(()=>ChangeGender()), title: 'Gender', value: controller.gender.value)),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(()=>ChangeDateOfBirth()), title: 'Date of Birth', value: controller.dob.value)),
            const Divider(),
            const SizedBox(height: 16,),
            
            Center(
              child: TextButton(
                  onPressed: (){
                    deleteAccountWarningPop();
                  },
                  child:const Text('Close Account',
                  style: TextStyle(color: Colors.red),)),
            )  

            ],
          ),
        ),
      ),
    );
  }
}
void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    Get.snackbar(
      'Success',
      'Text copied to clipboard',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  });
}