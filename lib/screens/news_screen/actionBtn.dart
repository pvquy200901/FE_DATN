import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../dashboard/dashboard_page.dart';
import '../../utils/constants.dart';
import '../team_screen/info_team.dart';
import 'TTD.dart';
import 'TTV.dart';
import 'comment.dart';
import 'news_screen.dart';

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
            if(actionTitle.compareTo("Xác nhận") == 0){
              api.confirmAction(code).then((value) {
                if (value) {
                  Fluttertoast.showToast(
                      msg: "Đã tạo bài tìm trận đấu thành công",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewsPage();
                  }));
                } else {
                  Fluttertoast.showToast(
                      msg: "Không thể bài tìm trận đấu",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
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