import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/user_screen/user_controller.dart';

import '../../utils/constants.dart';
import 'components/body.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hồ sơ", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Color(0xFF3E80DA),Color(0xC77AA3E5)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),
      ),
      body: Body(),

    );
  }
}
