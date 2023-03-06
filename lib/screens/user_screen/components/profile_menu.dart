import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key, required this.text, required this.icon, required this.press,

  }) : super(key: key);


  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          side: BorderSide(color: Color(0xFFF5F6F9),),
        padding: EdgeInsets.all(20),
        backgroundColor: Color(0x38E1E1E1),
      ),
         onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 25,
            ),
            SizedBox(width: 25),
            Expanded(child: Text(text,style: TextStyle(fontSize: 18))),
            //Icon(Icons.arrow_forward_ios),
          ],

        ),
      ),
    );
  }
}