import 'package:flutter/material.dart';
import 'confirm_user.dart';
import 'member_for_captian.dart';

class BodyManagerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                child: Text("Duyệt thành viên",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono',color: Colors.blueAccent)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new ConfirmUserScreen();
                  }));
                },
              ),
            ),
            const SizedBox(height: 20),
            MemberCaptian(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );



  }
}
