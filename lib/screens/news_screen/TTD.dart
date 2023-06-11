import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/screens/news_screen/postTTD.dart';

import '../../config/app_config.dart';
import '../../model/action_model/action.dart';
import '../../model/recomment_model/recomment.dart';
import '../../model/team_model/team_model.dart';
import '../../model/weather_model/weather_model.dart';
import '../../utils/constants.dart';
import 'actionBtn.dart';
import 'driver.dart';


class TTDPage extends StatefulWidget {
  const TTDPage({Key? key}) : super(key: key);

  @override
  State<TTDPage> createState() => _TTDPageState();

}
class _TTDPageState extends State<TTDPage> {
  bool check = true;
  bool check1 = false;
  String temperature = "";
  String level ="";
  String reputation = "";
  final format = DateFormat('dd-MM-yyyy HH:mm');
  DateTime timestamp = DateTime.now();

  int index = 2;
  double _xPosition = 270.0;
  double _yPosition = 120;
  final TextEditingController code = TextEditingController();
  String text = "";
  int dateTime = 0;
  Team team = Team();
  recomment m_recomment = recomment();
  WeatherData weather = WeatherData();
  double latitude = 10.88283465113124;
  double longitude = 106.78173797251489;

  List<mAction> actions = [];
  List<mAction> recomments = [];
  List<String> stadiums = [];

  bool isLoading = false;
  loadingData() async {
    stadiums = [];
    setState(() {
      isLoading = true;

    });
    if(text.compareTo("") == 0){
      actions = await api.getListAction("TTD");
    }
    else{
      actions = await api.searchingAction(text);
    }


    for(int i = 0 ; i< actions.length;i++){
      timestamp = format.parseStrict(actions[i].time!).add(const Duration(hours: 7)).toUtc();
      dateTime = timestamp.millisecondsSinceEpoch ~/ 1000;
      weather = await api.fetchWeatherData(latitude, longitude,dateTime);

      if (weather.temperature! >= 27.0) {
        temperature = "hot";
      } else if (weather.temperature! > 20 && weather.temperature! < 27) {
        temperature = "mild";
      } else {
        temperature = "cool";
      }
     /* if (weather.outlook!.compareTo("Clouds") == 0 ||
          weather.outlook!.compareTo("Mist") == 0) {

        txtOutlook = "Nhiều mây";
      }
      if (
      weather.outlook!.compareTo("Mist") == 0) {

        txtOutlook = "Sương mù";
      }
      if (weather.outlook!.compareTo("Clear") == 0) {
        txtOutlook = "Nắng";
      }
      if (weather.outlook!.compareTo("Rain") == 0) {
        txtOutlook = "Mưa";
      }
      if (weather.outlook!.compareTo("Thunderstorm") == 0) {
        txtOutlook = "Bão";
      }

      if (
      weather.outlook!.compareTo("Snow") == 0) {
        txtOutlook = "có Tuyết";
      }*/
      team = await api.getInfoTeam(actions[i].team);
      if (team.reputation! <= 100 && team.reputation! >= 80) {
        reputation = "high";
      }
      else if (team.reputation! < 80 && team.reputation! >= 50) {
        reputation = "normal";
      } else {
        reputation = "low";
      }

      if (team.level!.compareTo("Giỏi") == 0) {
        level = "high";
      } else {
        level = "normal";
      }

      m_recomment = await  api.postRecomment(
          [weather.outlook], [temperature], [level], [reputation]);
      if(m_recomment.prediction!.compareTo("yes") == 0){

        recomments.add(actions[i]);
      }
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGrey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: Text(
          "QDN Football",
          style: TextStyle(
            color: fbBlue,
          ),
        ),
        actions: [
          Container(
            width: 100,
            height: 70,
            child: Image.asset("assets/images/LOGO_QDN.png"),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                                children: [
                                  FutureBuilder(
                                      future: api.getInfoUserV2(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                              radius: 25.0,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.avatar!.isEmpty
                                                      ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU"
                                                      : "http://${AppConfig
                                                      .IP}:50000/api/File/image/${snapshot
                                                      .data!.avatar!}")
                                          );
                                        }
                                        else {
                                          return CircularProgressIndicator();
                                        }
                                      }),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<
                                              Color>(Colors.blue),
                                          minimumSize: MaterialStateProperty.all(
                                              Size(150, 50)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                          ),

                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return new createTTD();
                                              }));
                                        },
                                        child: Text('Tạo yêu cầu tìm trận đấu',
                                          textAlign: TextAlign.left, style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                      )
                                  ),
                                ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            /*Divider(
                            color: mainGrey,
                            thickness: 0.5,
                          ),
                          //Now we will create a Row of three button
                          Row(
                            children: [
                              actionButton(context, Icons.people,
                                  "Tuyển thành viên", Color(0xFFF23E5C), "",""),
                              actionButton(context, Icons.sports_soccer,
                                  "Tìm trận đấu", Color(0xFF58C472), "",""),
                            ],
                          ),*/
                            Divider(
                              color: mainGrey,
                              thickness: 0.5,
                            ),
                            TextFormField(
                              controller: code,
                              decoration: InputDecoration(
                                  labelText: "Tìm kiếm theo ngày tháng năm (dd-MM-yyyy),tên sân, tên đội",
                                  hintText: "Tất cả",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      setState(() {
                                        text = code.text;
                                        loadingData();
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(children: [
                      for (int i = 0; i < actions.length; i++)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: feedBox(context, actions[i].user!, actions[i].des!, actions[i].time!, actions[i].createTime!, actions[i].code!, actions[i].team!,actions[i].stadium!)
                        ),
                    ]),

                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            left: _xPosition,
            top: _yPosition,
            duration: Duration(milliseconds: 100),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _xPosition = 45.0;
                  _yPosition = 80.0;
                  check1 = true;
                });
              },
              onPanUpdate: (tapInfo) {
                setState(() {
                  _xPosition += tapInfo.delta.dx;
                  _yPosition += tapInfo.delta.dy;
                });
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/chatbot.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: check1,
                    child: Stack(children: [
                      Container(
                        width: 300,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[
                          50], // set background color
                          borderRadius: BorderRadius.circular(
                              5.0), // set border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Text("Danh sách các đội nên đá", style: TextStyle(fontSize: 18),),
                                SizedBox(height: 20,),

                                for(int i = 0; i< recomments.length; i++)
                                  recommentBox(context, recomments[i].user!,recomments[i].time!,recomments[i].code!,recomments[i].team!,recomments[i].stadium!),
                              ],
                            ),
                          )
                        ),
                      ),
                      Positioned(
                        right: -20,
                        top: -10,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _xPosition = 280.0;
                              _yPosition = 80.0;
                              check1 = false;
                            });

                          },
                          child: Icon(
                            size: 25,
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),


    );
  }
  Widget feedBox(BuildContext context,String userName, String des, String time,
      String createTime,String code, String team, String stadium) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        /*border: Border(bottom: BorderSide(
        color: Colors.black,
        width: 1
      )),*/
        borderRadius: BorderRadius.circular(12.0),
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                userName,
                style: TextStyle(
                  color: mainBlack,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),



              ),
            ),
            SizedBox(height: 10,),

            Text(
              des,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 10,),
            Text(
              "Tại sân bóng:" + stadium,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            SizedBox(height: 10,),
            Text(
              "Thời gian có thể đá:" + time,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 235),
              child: Text(
                createTime,
                style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
              ),
            ),
            divider(0.5),

            Row(
              children: [
                actionButton(context, Icons.group, "Xem đội", Colors.blue, team,time),

                actionButton(context, Icons.add_task, "Xác nhận", Colors.blue, code,"1"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget recommentBox(BuildContext context,String userName, String time,String code, String team, String stadium) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        /*border: Border(bottom: BorderSide(
        color: Colors.black,
        width: 1
      )),*/
        //borderRadius: BorderRadius.circular(12.0),
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                userName,
                style: TextStyle(
                  color: mainBlack,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10,),

            Text(
              team,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 10,),
            Text(
              "Tại sân bóng:" + stadium,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            SizedBox(height: 10,),
            Text(
              "Thời gian có thể đá:" + time,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: TextButton(
                onPressed: () {  }, child: Text(
                "Xem đội"
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
