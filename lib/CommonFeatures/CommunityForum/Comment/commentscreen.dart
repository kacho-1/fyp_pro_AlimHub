import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../Profile/Controller/Profilecontroller.dart';
import '../ShowPost/Model/ShowPostModel.dart';
import '../ShowPost/Wigets/postitem.dart';
import 'Controller/CommentController.dart';



class CommentsScreen extends StatelessWidget {
  CommentsScreen({Key? key,}) : super(key: key);

  final _commentController = Get.put(CommentController());
  final _arguments = Get.arguments;
  final Post post = Get.arguments as Post;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final controller = Get.put(ProfileController());
  String _getTimeAgo(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return timeago.format(date);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //_commentController.getPostId(_arguments[3]);
    _commentController.getPostId(post.postId!);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              PostItem(post: post), // Use the PostItem widget to display the post

              const Divider(color: Colors.black),
              Obx((){
                return Expanded(
                  child: ListView.builder(
                      itemCount: _commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = _commentController.comments[index];

                        final date =  DateTime.fromMillisecondsSinceEpoch(comment.time!);
                        final format =  DateFormat('dd/MM/yyyy HH:mm');
                        final dateString = format.format(date);
                       // final int commentTime = DateTime.now().subtract(Duration(hours: 15)).millisecondsSinceEpoch;


                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.userUrl!),
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.userName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                dateString,
                                style:  const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            comment.comment!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,

                            ),
                          ),
                        );
                      }),
                );
              }),
              const Divider(color: Colors.grey,),
              ListTile(
                title: TextFormField(
                  controller: _commentController.commentTextController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    // _commentController.addComment(_arguments[0], _arguments[1], _arguments[2], _arguments[3]);
                    _commentController.addComment(
                        controller.name.toString(),
                        controller.imageUrl.toString(),
                        controller.userId,

                        post.postId!
                    );
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
