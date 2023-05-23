import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/team_screen/team_controller.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../utils/constants.dart';
import 'createTeam.dart';
import 'item_team.dart';

class TeamPage extends GetView<TeamController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor1,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 0),
            child: Column(
              children: [
                Container(
                  width: 390,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Danh sách các đội bóng",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'RobotoMono',
                        ),
                      ),

                      TextButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return new createTeam();
                          }))
                        },
                        child: Text(
                          "Tạo đội",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 28, 159, 226),
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 50,
                ),


                FutureBuilder(
                    future: api.getListTeam(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                               child:
                               ItemTeam(
                                 address: snapshot.data![i].address!,
                                 desc: snapshot.data![i].des!,
                                 name: snapshot.data![i].name!,
                                 quality: snapshot.data![i].quality!,
                                 image: snapshot
                                          .data![i].logo!.isEmpty
                                          ? "https://img.freepik.com/free-vector/hand-drawn-flat-design-football-logo-template_23-2149373252.jpg"
                                         : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data![i].logo!}"),
                               ),
                        ]);
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
