import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/user_model/user_model.dart';
import 'package:untitled/utils/constants.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';
import 'manager_team_screen.dart';

class ItemMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ItemMemberState();
}

class ItemMemberState extends State<ItemMember> {
  Widget itemUser(String avatar, String name, String phone, String username) {
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15),
            ),
            child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(avatar,fit: BoxFit.cover)),
              
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: 'Open Sans'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                phone,
                style: TextStyle(
                    fontSize: 15, color: Colors.black, fontFamily: 'Open Sans'),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Xác nhận vào đội'),
                      content:
                      Text('Bạn có muốn thêm ${name} vào đội'),
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
                                .acceptUser(username)
                                .then((value) {
                              if (value) {
                                Future.delayed(
                                    const Duration(seconds: 0))
                                    .then((value) async {
                                  Get.back();
                                  Get.back();
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
                child:
                Image.asset("assets/images/confirm.png"),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Không cho vào đội'),
                      content:
                      Text('Bạn có muốn không cho ${name} vào đội'),
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
                                .cancelUser(username)
                                .then((value) {
                              if (value) {
                                Future.delayed(
                                    const Duration(seconds: 0))
                                    .then((value) async {
                                  Get.back();
                                  Get.back();
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
                child:
                Image.asset("assets/images/cancel.png"),
              ),
            ],
          )

        ],
      ),
    );
  }

  infoUser user = infoUser();
  List<UserModel> users = [];

  loadData() async {
    user = await api.getInfoUserV2();
    users = await api.getListUserComing(user.team);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(

        children: users
            .map((e) => itemUser(
            e.avatar!.isEmpty
                ? "https://cdn-icons-png.flaticon.com/512/25/25634.png"
                : "http://${AppConfig.IP}:50000/api/File/image/${e.avatar}",
            e.name!, e.phone!, e.username!))
            .toList());
  }
}
