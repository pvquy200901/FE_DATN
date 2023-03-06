import 'package:flutter/material.dart';
import 'package:untitled/screens/user_screen/manager_account/manager_account_input.dart';

import 'dart:math' as math;
import '../components/profile_pic.dart';

class BodyAccount extends StatelessWidget {


  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.1 * screenWidth,
        height: 1.1 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xB316BFC4),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color(0xDB4BE8CC),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/background2.png'),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Column(
          children: const [
            SizedBox(height: 20),
            ProfilePic(),
            SizedBox(height: 40),
            InputAccount(),
          ],
        ),
      ),
    );



  }
}
