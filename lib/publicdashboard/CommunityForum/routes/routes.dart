import 'package:fyp_pro/publicdashboard/CommunityForum/Comment/commentscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';



// I'm using Getx for state management

List<GetPage<dynamic>> getPages() {
  return [
    GetPage( name: '/commentscreen',
      page: () => CommentsScreen(),),
  ];
}