import 'package:flutter/material.dart';
import 'package:untitled/controller/app_controller.dart';

import 'captain_screen.dart';
import 'member.dart';

class BodyCaptian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                SizedBox(
                  height: 70,
                ),SizedBox(
                  width: 30,
                ),
                Text("Thành viên đội của tôi",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono')),

              ],
            ),

            const SizedBox(height: 20),
            Member(),
            const SizedBox(height: 30),

          ],
        ),
      ),
    );



  }
}
