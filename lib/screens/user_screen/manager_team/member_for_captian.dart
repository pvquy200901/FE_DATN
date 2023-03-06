import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/user_model/user_model.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';
import 'manager_team_screen.dart';

class MemberCaptian extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MemberCaptianState();
}

class MemberCaptianState extends State<MemberCaptian> {
  Widget itemUser(String avatar, String name, String team, String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Column(
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    avatar,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: SizedBox(
                      height: 55,
                      width: 55,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Color(0xFF0202),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Xóa thành viên'),
                              content:
                                  Text('Bạn có muốn xóa ${name} ra khỏi đội'),
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
                                        .removeUserInTeam(team, username)
                                        .then((value) {
                                      if (value) {
                                        Future.delayed(
                                                const Duration(seconds: 0))
                                            .then((value) async {
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
                                  child: const Text('Xóa'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Image.asset("assets/images/remove.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontFamily: 'Open Sans'),
          ),
        ],
      ),
    );
  }

  infoUser user = infoUser();
  List<UserModel> users = [];

  loadData() async {
    user = await api.getInfoUserV2();
    users = await api.getListUserInTeam(user.team);
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
                e.name!,
                user.team!,
                e.username!))
            .toList());
  }
}
