import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/stadium_controller.dart';

class StadiumPage extends GetView<StadiumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Stadium Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
