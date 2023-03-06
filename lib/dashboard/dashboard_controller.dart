import 'package:get/get.dart';

class DashboardController extends GetxController {
  DashboardController({required this.tabIndex});
  int tabIndex;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
