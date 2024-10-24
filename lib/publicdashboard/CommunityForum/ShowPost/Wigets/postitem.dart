import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Controller/Showpostcontroller.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Model/ShowPostModel.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Wigets/comment_widget.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Wigets/like_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';

class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;
  // GetX dependency injection
  final _homeController = Get.find<ShowPostController>();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(post.time!);
    final format = DateFormat("yMd");
    final dateString = format.format(date);

    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(post.userUrl!),
              ),
              title: Text(post.userName!, style: Theme.of(context).textTheme.bodyMedium),
              subtitle: Text(dateString),
              trailing: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Display Post Title
            if (post.postTitle != null && post.postTitle!.isNotEmpty)
              Text(
                post.postTitle!,
                textAlign: TextAlign.left,
              ),

            const SizedBox(height: 16),

            // Conditionally display the image if the URL is available
            if (post.postUrl != null && post.postUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post.postUrl!,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              ),

            const SizedBox(height: 16),

            // Like and Comment Widgets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LikeWidget(
                      likePressed: () {
                        _homeController.setLike(post.postId!);
                      },
                      likes: post.likes!.length,
                      isLiked: post.likes!.contains(_homeController.user.uid),
                      postId: post.postId!,
                    ),
                    CommentWidget(
                      comments: post.commentsCount!,
                      onPressed: () {
                        Get.toNamed('/commentscreen', arguments: post);
                      },
                    ),
                  ],
                ),
                IconButton(
                  onPressed: (){
                    _sharePost();

                  },
                  icon: Icon(
                    UniconsLine.telegram_alt,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _sharePost() {
    String shareContent = '';

    if (post.postTitle != null && post.postTitle!.isNotEmpty) {
      shareContent += "${post.postTitle!}\n\n";
    }

    if (post.postUrl != null && post.postUrl!.isNotEmpty) {
      shareContent += "Check out this image: ${post.postUrl!}\n";
    }

    shareContent += "Shared via AlimHub Community";

    Share.share(shareContent); // Use share_plus to share the content
  }
}




/*
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Controller/Showpostcontroller.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Model/ShowPostModel.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Wigets/comment_widget.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Wigets/like_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';



class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
    required this.post,
  })
      : super(key: key);
  final Post post;
  // GetX dependency injection
  final _homeController = Get.find<ShowPostController>();

  @override
  Widget build(BuildContext context) {

    final date =  DateTime.fromMillisecondsSinceEpoch(post.time!);
    final format =  DateFormat("yMd");
    final dateString = format.format(date);

    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                NetworkImage(post.userUrl!),
              ),
              title: Text(post.userName!, style: Theme.of(context).textTheme.bodyMedium),
              subtitle: Text(dateString),
              trailing: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Text(post.postTitle!, textAlign: TextAlign.left,),
            const SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post.postUrl!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LikeWidget(
                      likePressed: (){
                        _homeController.setLike(post.postId!);
                      },
                      likes: post.likes!.length,
                      isLiked: post.likes!.contains(_homeController.user.uid),
                      postId: post.postId!,
                    ),
                    CommentWidget(
                      comments: post.commentsCount!,
                     */
/* onPressed: (){
                        Get.toNamed('/commentscreen', arguments: [
                          post.userName, //0
                          post.userUrl, //1
                          post.userUid, //2
                          post.postId //3
                        ] );*//*

                      onPressed: (){
                        Get.toNamed('/commentscreen', arguments: post);
                      },
                    ),
                  ],
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      UniconsLine.telegram_alt,
                      color: Theme.of(context).iconTheme.color,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
*/
