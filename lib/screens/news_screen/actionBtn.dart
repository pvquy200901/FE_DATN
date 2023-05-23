import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/dashboard_page.dart';
import '../../utils/constants.dart';
import '../team_screen/info_team.dart';
import 'TTD.dart';
import 'TTV.dart';
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
            if(actionTitle.compareTo("Tuyển thành viên") == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new TTVPage();
              }));
            }
            if(actionTitle.compareTo("Tìm trận đấu") == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new TTDPage();
              }));
            }
            if(actionTitle.compareTo("Xem đội") == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new InfoTeam(name: code);
              }));
            }
          },
          icon: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          label: Text(
            actionTitle,
            style: TextStyle(
              color: mainBlack,
              fontSize: 16
            ),
          ),

        ),


      ],
    ),

  );
}