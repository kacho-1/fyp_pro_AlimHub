
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Screens/ApointmentPAge.dart';
import '../Screens/homescreen.dart';

class BTNavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [ConsultancyHome(),ApointmentPage()];
}
