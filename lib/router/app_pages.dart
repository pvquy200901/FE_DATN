import 'package:get/get.dart';

import '../dashboard/dashboard_binding.dart';
import '../dashboard/dashboard_page.dart';
import 'app_router.dart';


class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
