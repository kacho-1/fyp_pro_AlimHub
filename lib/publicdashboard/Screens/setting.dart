import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/Authentication/SignIn.dart';
import 'package:fyp_pro/CommonFeatures/Profile/profilescreen.dart';
import 'package:fyp_pro/publicdashboard/setting/screens/FAQ.dart';
import 'package:fyp_pro/publicdashboard/setting/screens/feedbackScreen.dart';
import 'package:fyp_pro/publicdashboard/setting/screens/location.dart';
import 'package:fyp_pro/publicdashboard/setting/screens/privatepolicy.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../CommonFeatures/Customs/CustomAppbar.dart';
import '../../CommonFeatures/Customs/CustomContainier.dart';
import '../../CommonFeatures/Customs/CustomSettingboarding.dart';
import '../../CommonFeatures/Customs/customSettingsection.dart';
import '../../CommonFeatures/Profile/Controller/Profilecontroller.dart';
import '../setting/screens/bankaccountscreen.dart';




class SettingScreen extends StatefulWidget {
   const SettingScreen({super.key});


  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences (login state and role)
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Navigate to the Signin screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Signin()),
          (Route<dynamic> route) => false,  // Remove all routes from the stack
    );
  }
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child:Column(
                children: [

                  CAppBar(

                    title: Text('Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),

                  ),
                  const SizedBox(height: 32,),
                  ListTile(
                    leading: ClipOval(
                      child: Obx(()=>CachedNetworkImage(
                        height: 80-12*2,
                        width: 80-12*2,
                        fit: BoxFit.cover,
                        imageUrl: controller.imageUrl.value,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/my.png'),
                      )),
                    ),
                    title: Obx(()=>Text(controller.name.value,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(color:Colors.white),)),
                    subtitle:Text(controller.email.value,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color:Colors.grey.shade300),),
                    trailing :IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    }, icon: const Icon(Iconsax.edit,color: Colors.white,)),
                  )
                ],
              )
            ),
            Padding(padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const TSectionsetting(title: 'Account Setting',showActionButton: false,),
                const SizedBox(height: 16,),
                TSettingBody(
                  icon: Iconsax.bank,
                  title: 'Bank Account',
                  subtitle: 'Add Account Details',
                  traling: null,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const BankAccount()));
                  },
                ),
                TSettingBody(
                  icon: Icons.notifications_none,
                  title: 'Notification',
                  subtitle: 'Set any type of Notification',
                  traling: null,
                  onTap: (){},
                ),
                TSettingBody(
                  icon: Icons.security_outlined,
                  title: 'Account Privacy',
                  subtitle: 'Managed Data usage and connected accounts ',
                  traling: null,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicyPage()));
                  },
                ),
                const SizedBox(height: 16,),
                TSettingBody(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: 'Set the location',
                  traling: null,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LocationScreen()));
                  },
                ),
                const SizedBox(height:
                  16,),
                TSettingBody(
                  icon: Icons.question_answer_outlined,
                  title: 'FAQs',
                  subtitle: 'Frequently Asked Questions',
                  traling: null,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const FAQPage()));
                  },
                ),
                const SizedBox(height: 16,),
                TSettingBody(
                  icon: Iconsax.message,
                  title: 'Feedback',
                  subtitle: 'Add your Feedback',
                  traling: null,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const FeedbackFormScreen()));
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () async{
                    await _logout(context);

                  }, child: const Text('logout',style: TextStyle(
                    color: Colors.black
                  ),)
                  ),
                )
                ,
                const SizedBox(height: 16*2.5),

              ],
            ),)


          ],
        ),
      ),
    );
  }
}
