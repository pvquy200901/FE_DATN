import 'package:get/get.dart';
import 'package:untitled/screens/team_screen/team_controller.dart';

import '../screens/home_screen/home_controller.dart';
import '../screens/news_screen/news_controller.dart';
import '../screens/stadium_screen/stadium_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(tabIndex: 0));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TeamController>(() => TeamController());
    Get.lazyPut<StadiumController>(() => StadiumController());
    Get.lazyPut<NewsController>(() => NewsController());
    //Get.lazyPut<AccountController>(() => AccountController());
  }
}
