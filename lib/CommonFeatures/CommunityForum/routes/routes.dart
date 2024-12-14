import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Comment/commentscreen.dart';



// I'm using Getx for state management

List<GetPage<dynamic>> getPages() {
  return [
    GetPage( name: '/commentscreen',
      page: () => const CommentsScreen(),),
  ];
}