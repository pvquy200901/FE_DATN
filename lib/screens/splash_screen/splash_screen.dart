import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/app_controller.dart';
import 'package:untitled/screens/login_screen/login_screen.dart';

class SplashPage extends StatelessWidget {

  Future loadData() async{
    await Future.delayed(Duration (seconds: 1));
    if(appController.checkLogin()){
      Get.offAllNamed("/home");
    }
    else{
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
          child: Center(
            child: Text(
              "LOADING 99%",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },),
    );
  }
}
