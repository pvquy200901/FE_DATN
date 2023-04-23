import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/app_controller.dart';
import 'package:untitled/utils/constants.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../widgets/categoryItem.dart';
import '../widgets/judulWidget.dart';
import '../widgets/popularWidget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor1,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: mediaQueryData.viewInsets,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 44, left: 25, right: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Xin chào",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'RobotoMono',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                appController.user!,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'RobotoMono'),
                              )
                            ],
                          )
                        ],
                      ),
                      // Text("Halo3"),
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/LOGO_QDN.png"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  JudulWidget(judul: "Danh sách các sân bóng"),
                  SizedBox(
                    height: 22,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FutureBuilder(
                            future: api.getListStadiumForCustomer(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: CategoryItem(
                                            image:
                                            snapshot
                                            .data![i].images!.isEmpty
                                            ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1"
                                            : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data![i].images![0]}",
                                            type: "Sân 5",
                                            name: snapshot.data![i].name!,
                                            address: snapshot.data![i].address!,
                                            money: snapshot.data![i].price
                                                .toString(),),
                                      ),
                                  ],
                                );
                              } else {
                                return Container(

                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  JudulWidget(judul: "Danh sách các đội bóng"),
                  SizedBox(
                    height: 22,
                  ),
                  FutureBuilder(
                      future: api.getListTeam(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: PopularWidget(
                                      address: snapshot.data![i].address!,
                                      desc: snapshot.data![i].des!,
                                      people: snapshot.data![i].quality!,
                                      name: snapshot.data![i].name!,
                                      image: snapshot.data![i].logo!.isEmpty
                                          ? "https://img.freepik.com/free-vector/hand-drawn-flat-design-football-logo-template_23-2149373252.jpg"
                                          : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data![i].logo!}"),
                                ),
                            ],
                          );
                        } else {
                          return Container(

                            width: 100,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
