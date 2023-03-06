import 'package:flutter/material.dart';
import 'package:untitled/controller/app_controller.dart';

import 'captain_screen.dart';
import 'confirm_user.dart';
import 'member.dart';
import 'member_for_captian.dart';

class BodyManagerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(

                child: Text("Duyệt thành viên",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono',color: Colors.blueAccent)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new ConfirmUserScreen();
                  }));
                },
              ),
            ),
            MemberCaptian(),
            const SizedBox(height: 30),


          ],
        ),
      ),
    );



  }
}
