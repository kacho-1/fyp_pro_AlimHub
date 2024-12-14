/*
import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/chat/chatscreen.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';


class AlimConversationMain extends StatelessWidget {
  final String appoinmetId;

   const AlimConversationMain({required this.appoinmetId,
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
          builder: (context)=>AlimChatScreen(
              ConversationId: conversation.id))
      );
        }
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: TColors.primary,
        onPressed: (){
          _startNewChat(context);
        },
        child: const Icon(Icons.chat),),
    );
  }
  void _startNewChat(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          final userIdController = TextEditingController();
          return AlertDialog(
            title: const Text('Start New Chat'),
            content: Text(appoinmetId),
            actions: [
              TextButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                onPressed:() { Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=>AlimChatScreen(
                            ConversationId: appoinmetId))
                );
                }, child: const Text('Go'),

              ),

            ],
          );

        });
  }
}
*/
