import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../order_screen/order_screen.dart';

class InfoStadium extends StatelessWidget {
  final String name;

  const InfoStadium({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.getInfoStadium(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 380,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot
                                .data!.images![0].isEmpty
                                ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1"
                                : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.images![0]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 25,
                      top: 44,
                      left: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  size: 18,
                                  Icons.keyboard_arrow_left_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data!.name!,
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          SizedBox(
                            width: 45,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 380 - 110,
                      bottom: 0,
                      // bottom: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.name!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${snapshot.data!.price!} VND",

                                        // style: AppTextStyle.defaultHeaderOne.copyWith(
                                        //   fontSize: 24,
                                        // ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "/1 giờ",
                                        // style: AppTextStyle.smallText.copyWith(
                                        //   color: AppColor.secondTextColor,
                                        //   fontSize: 12,
                                        // ),
                                      ),
                                    ],
                                  )


                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color.fromARGB(
                                        255, 28, 159, 226),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    snapshot.data!.address!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(
                                          255, 28, 159, 226),
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                snapshot.data!.contact!,
                                //   style:
                                //   AppTextStyle.defaultStyle.copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ảnh",
                                    // style: AppTextStyle.defaultHeaderOne,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for(int i = 0 ; i < snapshot.data!.images!.length ; i ++)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: PreviewImage(
                                          image: snapshot
                                              .data!.images![i].isEmpty
                                              ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1"
                                              : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.images![i]}"),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                height: 48,
                                width: 325,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 28, 159, 226),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return new OrderStadium(name: name,);
                                      }));
                                    },
                                    child: Center(
                                      child: Text(
                                        "Đặt sân",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'RobotoMono',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding:
                              EdgeInsets.only(left: 25, right: 25, top: 37),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
