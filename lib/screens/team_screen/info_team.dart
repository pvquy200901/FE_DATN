import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';
import 'package:untitled/screens/team_screen/avatar_widget.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../user_screen/manager_team/manager_team_screen.dart';

class InfoTeam extends StatelessWidget {
  final String name;

  const InfoTeam({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
       future: api.getInfoTeam(name),
       builder: (context, snapshot){
        if(snapshot.hasData){
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
                          image: NetworkImage(snapshot.data!.logo!.isEmpty
                              ? "https://img.freepik.com/free-vector/hand-drawn-flat-design-football-logo-template_23-2149373252.jpg"
                              : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.logo!}"),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                     snapshot.data!.name!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'RobotoMono',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Color.fromARGB(255, 28, 159, 226),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          snapshot.data!.address!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 28, 159, 226),
                                            fontFamily: 'RobotoMono',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  // width: 20.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.quality.toString(),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        " người",
                                        // style: AppTextStyle.smallText.copyWith(
                                        //   color: AppColor.secondTextColor,
                                        //   fontSize: 12,
                                        // ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Miêu tả",
                                style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                             snapshot.data!.des!,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Độ uy tín: ${snapshot.data!.reputation}",
                                  style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Trình độ: ${snapshot.data!.level}",
                                  style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for(int i = 0 ; i < snapshot.data!.imageTeam!.length; i ++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: PreviewImage(image: snapshot.data!.imageTeam![i].isEmpty
                                          ? "https://img.freepik.com/free-vector/hand-drawn-flat-design-football-logo-template_23-2149373252.jpg"
                                          : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.imageTeam![i]}"),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Thành viên đội",
                                  // style: AppTextStyle.defaultHeaderOne,
                                ),
                              ],
                            ),

                            FutureBuilder(
                                future: api.getListUserInTeam(name),
                                builder: (context, snapshot){
                                if(snapshot.hasData){
                                  return Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 10,
                                    children: [
                                      for(int i = 0 ; i < snapshot.data!.length; i ++)
                                          AvatarUser(
                                              image: snapshot.data![i].avatar!.isEmpty
                                                  ? "https://cdn-icons-png.flaticon.com/512/25/25634.png"
                                                  : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data![i].avatar!}",
                                              name: snapshot.data![i].chucVu == true ? "Đội trưởng": snapshot.data![i].name!),
                                        ],
                                  );
                                }
                                else{
                                  return CircularProgressIndicator();
                                }
                            }),

                            SizedBox(
                              height: 100,
                            ),

                            FutureBuilder(
                                future: api.getInfoUser(),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return Visibility(
                                      visible: (snapshot.data!.team!.isNotEmpty)?false:true,
                                      child: Container(
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
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Xác nhận tham gia vào đội'),
                                                  content:
                                                  Text('Bạn có muốn tham gia vào đội'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context, 'Cancel'),
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        Navigator.pop(context, 'OK'),
                                                        api
                                                            .joinTeam(name)
                                                            .then((value) {
                                                          if (value) {
                                                            Future.delayed(
                                                                const Duration(seconds: 0))
                                                                .then((value) async {
                                                              // Get.back();
                                                              // Get.back();
                                                              Navigator.pushReplacement<void, void>(
                                                                context,
                                                                MaterialPageRoute<void>(
                                                                  builder: (BuildContext context) =>  ManagerTeamPage(),
                                                                ),
                                                              );
                                                            });
                                                          }
                                                        }),
                                                      },
                                                      child: const Text('Xác nhận'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                "Tham gia",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: 'RobotoMono',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                })
                          ],
                        ),
                        padding: EdgeInsets.only(left: 25, right: 25, top: 37),
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
        }
        else{
          return CircularProgressIndicator();
        }
   });

  }
}
