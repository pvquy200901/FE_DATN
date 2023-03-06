import 'package:flutter/material.dart';
import 'package:untitled/controller/app_controller.dart';

import '../../../utils/constants.dart';
import 'body_captian_user.dart';
import 'body_manager_user.dart';
import 'member_for_captian.dart';

class CaptainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý thành viên", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
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

      body: BodyManagerUser(),


    );
  }
}
