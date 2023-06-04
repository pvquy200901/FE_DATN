import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../utils/constants.dart';
import 'body_team.dart';

class ManagerTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đội của tôi", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [Color(0xFF3E80DA),Color(0xC77AA3E5)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
            )
          ),
        ),
      ),

      body: FutureBuilder(
          future: api.getInfoUserV2(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data!.team!.isNotEmpty) ?BodyTeam():Center(child: Text("Bạn chưa có đội bóng",style: TextStyle(fontSize: 20, color: Colors.red),));
            }
            else{
              return CircularProgressIndicator();
            }
          })


    );
  }
}
