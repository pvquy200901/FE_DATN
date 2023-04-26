import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/user_screen/manager_account/manager_account_screen.dart';

import '../../../controller/app_controller.dart';
import '../../login_screen/login_screen.dart';
import '../chat/groupChat.dart';
import '../history_order/history_order.dart';
import '../manager_team/manager_team_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
          ProfilePic(),
          SizedBox(height: 40),
          ProfileMenu(
            text: "Quản lý tài khoản",
            icon: "assets/images/user-solid.svg",
            press: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return new ManagerAccountPage();
            }))
            },
          ),
          ProfileMenu(
            text: "Đội của tôi",
            icon: "assets/images/users-solid.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new ManagerTeamPage();
              }));
            },
          ),
          ProfileMenu(
            text: "Chat",
            icon: "assets/images/rocketchat.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new GroupChatPage();
              }));
            },
          ),
          ProfileMenu(
            text: "Lịch sử đặt sân",
            icon: "assets/images/receipt-solid.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new HistoryOrderPage();
              }));
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/images/skiing-nordic-solid.svg",
            press: () {
                    appController.resetLoginData().then((value){
                      Get.offAll(() => LoginScreen());
                    });

            },
          ),
        ],
      ),
    );
  }
  }
