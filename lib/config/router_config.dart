import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/dashboard/dashboard_page.dart';
import 'package:untitled/screens/login_screen/login_screen.dart';
import 'package:untitled/screens/splash_screen/splash_screen.dart';

import '../controller/app_controller.dart';
import '../dashboard/dashboard_binding.dart';
import '../screens/user_screen/manager_team/body_team.dart';
import '../screens/user_screen/manager_team/captain_screen.dart';
import '../screens/user_screen/manager_team/manager_team_screen.dart';


class RouteConfig {
  static final List<RouteToPage> _routeToPage = [

    //RouteToPage(name: '/login', page: const LoginScreen(), roles:[] ),
   // RouteToPage(name: '/home', page: HomeScreen(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/cau_hinh', page: Container(),roles: ['admin','operation','manager']),
    // // RouteToPage(name: '/cau_hinh_danh_muc', page: Container(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/cau_hinh_tai_khoan', page: ConfigAccountScreen(),roles: ['admin']),
    // RouteToPage(name: '/danh_sach_duong_pho', page: ListStreetsScreen(),roles: ['admin']),
    // RouteToPage(name: '/danh_sach_khach_hang', page: ListCustomersScreen(),roles: ['admin','operation']),
    // RouteToPage(name: '/type', page: TypeScreen(),roles: ['admin','operation','manager']),
    // RouteToPage(name: '/admin_history', page: AdminHistoryView(),roles: ['admin']),
  ];
  final List<GetPage> _route = _routeToPage
      .map((route) => GetPage(name: route.name, page: () => route.page))
      .toList();

  final List<RouteModel> _navbar = [
    // RouteModel(route: '/cau_hinh', label: 'Cấu hình',group: '/cau_hinh',children: [
    //   RouteModel(route: '/cau_hinh_tai_khoan', label: 'Cấu hình tài khoản',group: '/cau_hinh',children: [],screen: ConfigAccountScreen()),
    //   RouteModel(route: '/type', label: 'Loại',group: '/cau_hinh',children: [],screen: TypeScreen()),
    // ],screen: ConfigAccountScreen()),
    // RouteModel(route: '/danh_sach_duong_pho', label: 'Danh sách đường phố',children: [],group: '/danh_sach_duong_pho',screen: ListStreetsScreen()),
    // RouteModel(route: '/danh_sach_khach_hang', label: 'Danh sách khách hàng',children: [],group: '/danh_sach_khach_hang',screen: ListCustomersScreen()),
    // RouteModel(route: '/admin_history', label: 'Lịch sử',group: '/lich_su',children: [],screen: AdminHistoryView()),
  ];
  List<GetPage> get getRoute => [

    GetPage(name: '/home', page: () => DashboardPage(),binding: DashboardBinding()),
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/team', page: () => ManagerTeamPage()),
  ];
  List<RouteModel> getNavbar() {
    List<RouteModel> list = [];
    for (RouteModel model in _navbar) {
      List<RouteToPage> listRouteToPage = [];
      listRouteToPage.addAll(_routeToPage
          .where((element) => element.name == model.route)
          .toList());
      if (listRouteToPage.isNotEmpty) {
        RouteToPage route = listRouteToPage.first;
        if (route.roles.isEmpty || route.roles.contains(appController.role)) {
          list.add(model);
        }
      }
    }
    return list;
  }

  List<RouteToPage> get getRouteToPage => _routeToPage;
}

class RouteModel {
  final String route;
  final String label;
  final String group;
  final List<RouteModel> children;
  final Widget screen;
  RouteModel(
      {required this.route,
        required this.label,
        required this.group,
        required this.children,
        required this.screen});
}

class RouteToPage {
  final String name;
  final Widget page;
  final List<String> roles;
  RouteToPage({required this.name, required this.page, required this.roles});
}
