/*
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Chat/Screens/publicChatScreen.dart';
import '../../../../../CommonFeatures/Customs/CustomColor.dart';



class ConversationMain extends StatelessWidget {
  final String appoinmetId;

  const ConversationMain({required this.appoinmetId,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Conversation',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
        ),
        backgroundColor: TColors.primary,
      ),
      body: ZIMKitConversationListView(
          onPressed: (context, conversation, _)
          {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>ChatScreen(
                        ConversationId: conversation.id))
            );
          }
      ),

    );
  }

}
*/
