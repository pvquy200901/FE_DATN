import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/app_controller.dart';
import 'package:untitled/screens/home_screen/home_screen.dart';

import '../../../api/api.dart';
import '../../../model/user_model/user_model.dart';
import 'captain_screen.dart';
import 'member.dart';

class BodyTeam extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BodyTeamState();
}
class BodyTeamState extends State<BodyTeam>{
  infoUser user = infoUser();

  loadData()async{
    user = await api.getInfoUserV2();

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

    return Visibility(
      visible: (user.team!.isNotEmpty)?true:false,
      child: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text("Thành viên đội của tôi",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono')),
                  appController.role == "true"? GestureDetector(
                    child: Text("Quản lý đội",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono',color: Colors.blueAccent)),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return new CaptainScreen();
                      }));
                    },
                  ):const SizedBox(),
                  appController.role == "false"? OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Xác nhận rời đội'),
                          content:
                          Text('Bạn có muốn rời đội'),
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
                                    .outTeam(user.team!)
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
                                          builder: (BuildContext context) =>  HomePage(),
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
                    Image.asset("assets/images/sign.png"),
                  ):const SizedBox()
                ],
              ),
              Visibility(
                  visible:(user.state! == 4)?true:false ,
                  child:  Text("Vui lòng đợi đội trưởng duyệt",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono',color: Colors.red))),

              const SizedBox(height: 20),
              Member(),
              const SizedBox(height: 30),
              Text("Lịch thi đấu",style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono')),
            ],
          ),
        ),
      ),
    );



  }


}
