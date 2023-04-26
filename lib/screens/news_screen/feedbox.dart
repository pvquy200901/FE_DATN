import 'package:flutter/material.dart';
import 'package:untitled/screens/news_screen/driver.dart';
import '../../config/app_config.dart';
import '../../utils/constants.dart';
import 'actionbtn.dart';

Widget feedBox(BuildContext context,String userName, int point, String date,
    String contentText, String contentImg,String code) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    width: double.infinity,
    decoration: BoxDecoration(
      /*border: Border(bottom: BorderSide(
        color: Colors.black,
        width: 1
      )),*/
      borderRadius: BorderRadius.circular(12.0),
      color: kBackgroundColor,
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: mainBlack,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),



              ),
              Text(
                "Độ uy tín: " + point.toString(),
                style: TextStyle(
                  color: mainBlack,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),



              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
              width: 500,
              height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: (contentImg != "")? NetworkImage("http://${AppConfig.IP}:50000/api/File/image/${contentImg}"): NetworkImage("https://static.standard.co.uk/2022/03/15/19/2022-03-15T172625Z_1107313512_UP1EI3F1CFY2Q_RTRMADP_3_SOCCER-CHAMPIONS-MUN-ATM-REPORT.JPG?width=1200"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          if (contentText != "")
            Text(
              contentText,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),

          Padding(
            padding: const EdgeInsets.only(left: 230),
            child: Text(
              date,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          divider(0.5),

          Row(
            children: [
               actionButton(context, Icons.comment, "Bình Luận", mainBlack, code),
            ],
          )
        ],
      ),
    ),
  );
}