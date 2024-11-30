
import 'package:flutter/material.dart';
import '../../CommonFeatures/CommunityForum/Main/main_screen.dart';

class CommunityForum extends StatefulWidget {
  const CommunityForum({super.key});

  @override
  State<CommunityForum> createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostMainScreen(),

    );
  }
}
