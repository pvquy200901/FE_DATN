import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/user_screen/user_controller.dart';

import '../../controller/app_controller.dart';
import '../splash_screen/splash_screen.dart';

class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "User Page",
            style: TextStyle(fontSize: 20),

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed: () {
            appController.resetLoginData().then((value){
              Get.offAll(() => SplashPage());
            });
           
          }
      ),
    );
  }
}
