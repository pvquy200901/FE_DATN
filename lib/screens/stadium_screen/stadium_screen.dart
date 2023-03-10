import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/searchBox.dart';
import 'package:untitled/screens/stadium_screen/stadium_controller.dart';
import 'package:untitled/screens/stadium_screen/stadium_item.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../utils/constants.dart';

class StadiumPage extends GetView<StadiumController> {
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
                        "Danh sách sân bóng",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      SizedBox(
                        width: 65,
                      )
                    ],
                  ),
                ),
                SearchBox(),
                FutureBuilder(
                    future: api.getListStadiumForCustomer(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: IteamStadium(
                                  address: snapshot.data![i].address!,
                                  desc: snapshot.data![i].contact!,
                                  name: snapshot.data![i].name!,
                                  money: snapshot.data![i].price!,
                                  image: snapshot
                                      .data![i].images!.isEmpty
                                      ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1"
                                      : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data![i].images![0]}"),
                            )
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
