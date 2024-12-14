
import 'package:get/get.dart';
import '../Screens/ApointmentPAge.dart';
import '../Screens/homescreen.dart';

class BTNavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const ConsultancyHome(),const AppointmentPage()];
}
