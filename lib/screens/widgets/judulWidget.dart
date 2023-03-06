import 'package:flutter/material.dart';
import 'package:untitled/dashboard/dashboard_page.dart';

import '../stadium_screen/stadium_screen.dart';
import '../team_screen/team_screen.dart';
import 'package:get/get.dart';
class JudulWidget extends StatelessWidget {
  // const judulWidget({
  //   Key? key,
  // }) : super(key: key);
  final String judul;
  JudulWidget({
    required this.judul,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: TextStyle(fontSize: 20, color: Color.fromARGB(
              255, 8, 31, 42),fontFamily: 'RobotoMono')
        ),
        Spacer(),
        GestureDetector(
          child: Text("Xem tất cả",
              style:
              TextStyle(fontSize: 16, fontFamily: 'RobotoMono', color: Color.fromARGB(255, 28, 159, 226))),
          onTap: (){
            if(judul.compareTo("Danh sách các đội bóng") == 0){
              Get.offAll(()=> DashboardPage(index: 3,));
            }
            if(judul.compareTo("Danh sách các sân bóng") == 0){
              Get.offAll(()=> DashboardPage(index: 1,));

            }


          },
        ),

        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.arrow_forward,
          color: Color.fromARGB(255, 28, 159, 226),
          size: 12,
        )
      ],
    );
  }
}
