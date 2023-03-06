import 'package:flutter/material.dart';
import 'package:untitled/model/user_model/user_model.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';
import '../../../utils/constants.dart';

class Member extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MemberState();
}

class MemberState extends State<Member>{

  Widget itemUser(String avatar, String name){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: Image.network(avatar,fit: BoxFit.cover)),
          ),

          SizedBox(
            height: 10,
          ),
          Text(name, style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Open Sans'),),
        ],
      ),
    );
  }

  infoUser user = infoUser();
  List<UserModel>  users= [];

  loadData()async{
    user = await api.getInfoUserV2();
    users = await api.getListUserInTeam(user.team);
    setState(() {

    });
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
        children: users.map((e) => itemUser(e.avatar!.isEmpty?"https://cdn-icons-png.flaticon.com/512/25/25634.png":"http://${AppConfig.IP}:50000/api/File/image/${e.avatar}", e.name!)).toList()
    );
  }
}