import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'comment.dart';

Widget actionButton(BuildContext context,IconData icon, String actionTitle, Color iconColor,String code) {
  return Expanded(
    child: Column(
      children: [
        TextButton.icon(
          onPressed: () {
            if(actionTitle.compareTo("Bình Luận") == 0){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new Comments(code: code);
            }));
            }
          },
          icon: Icon(
            icon,
            color: iconColor,
            size: 15,
          ),
          label: Text(
            actionTitle,
            style: TextStyle(
              color: mainBlack,
              fontSize: 15
            ),
          ),

        ),


      ],
    ),

  );
}