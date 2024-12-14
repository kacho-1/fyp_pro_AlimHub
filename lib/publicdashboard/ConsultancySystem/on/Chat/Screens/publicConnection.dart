/*
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Chat/Screens/UserConversationMain.dart';
import 'package:get/get.dart';
import '../../../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class UserConnectionScreen extends StatefulWidget {

  final String appointment;
  const UserConnectionScreen({
    required this.appointment,
    super.key});

  @override
  State<UserConnectionScreen> createState() => _UserConnectionScreenState();
}

class _UserConnectionScreenState extends State<UserConnectionScreen> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Go to Chat Screen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
          ),
          backgroundColor: TColors.primary,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 280,),
              const Text('Start Text-Based Conversation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),),
              Center(
                child: IconButton(
                    onPressed: ConnectUser,
                    icon: const Icon(Icons.chat,color: Colors.blue,size: 40,)),
              ),
              const Text('Click to Start',
                style:TextStyle(
                  color: Colors.grey
                ) ,)

            ],
          ),
        )
    );
  }

  Future <void> ConnectUser () async{
    await ZIMKit().connectUser(
      id:controller.userId,
      name:controller.name.value,
      avatarUrl:controller.imageUrl.value,

    );
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context)=>ConversationMain(appoinmetId:widget.appointment,)));
  }
}
*/
