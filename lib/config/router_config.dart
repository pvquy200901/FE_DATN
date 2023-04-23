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

  ];
  final List<GetPage> _route = _routeToPage
      .map((route) => GetPage(name: route.name, page: () => route.page))
      .toList();

  final List<RouteModel> _navbar = [

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
