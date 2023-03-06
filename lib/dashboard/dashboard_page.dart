import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/stadium_screen.dart';

import '../screens/home_screen/home_screen.dart';
import '../screens/news_screen/news_screen.dart';
import '../screens/team_screen/team_screen.dart';
import '../screens/user_screen/user_screen.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final int index;

  const DashboardPage({super.key, this.index = 0});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(tabIndex: index),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                StadiumPage(),
                NewsPage(),
                TeamPage(),
                UserPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.house_alt_fill,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.sportscourt_fill,
                label: 'Stadium',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.news_solid,
                label: 'News',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.group_solid ,
                label: 'Team',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person_solid,
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
