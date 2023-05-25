import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';
import 'package:untitled/screens/team_screen/avatar_widget.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../model/team_model/team_model.dart';
import '../../model/weather_model/weather_model.dart';
import '../order_screen/dialog_payment.dart';
import '../user_screen/manager_team/manager_team_screen.dart';
import 'dialog_report.dart';

class InfoTeam extends StatefulWidget {
  final String name;
  final String time;
  InfoTeam({Key? key, required this.name, required this.time}) : super(key: key);
  @override
  _InfoTeamState createState() => _InfoTeamState();
}
  class _InfoTeamState extends State<InfoTeam> {
    double _xPosition = 280.0;
    double _yPosition = 80.0;
    bool isLoading = false;
    bool check = false;
    bool check1 = false;
    String outlook = "";
    String temperature = "";
    String level ="";
    String reputation = "";
    String txtOutlook = "";
    List<String> stadiums = [];
    Team team = Team();
    WeatherData weather = WeatherData();
    double latitude = 10.88283465113124;
    double longitude = 106.78173797251489;
    loadData() async {

      setState(() {
        isLoading = true;
        if(widget.time == "1"){
          check1 = false;
        }
        else{
          check1 = true;
        }
      });
      stadiums = await api.getListStadiumTime(widget.time);
      team = await api.getInfoTeam(widget.name);
      weather = await api.fetchWeatherData(latitude, longitude);
      if (weather.temperature! >= 27.0) {
        temperature = "hot";
      } else if (weather.temperature! > 20 && weather.temperature! < 27) {
        temperature = "mild";
      } else {
        temperature = "cool";
      }
      if (weather.outlook!.compareTo("Clouds") == 0 ||
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
      }

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

      setState(() {
        isLoading = false;
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

   return FutureBuilder(
       future: api.getInfoTeam(widget.name),
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
                        IconButton(onPressed: ()=>{
                        showDialog(context: context, builder: (BuildContext context){
                        return ReportDialog(nameStadium: widget.name,);
                        })
                        }, icon: Icon(Icons.warning_amber_outlined, color: Colors.redAccent, size: 30,))
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
                                future: api.getListUserInTeam(widget.name),
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
                                                            .joinTeam(widget.name)
                                                            .then((value) {
                                                          if (value) {
                                                            Future.delayed(
                                                                const Duration(seconds: 0))
                                                                .then((value) async {
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

                  (widget.time != "1")?AnimatedPositioned(
                    left: _xPosition,
                    top: _yPosition,
                    duration: Duration(milliseconds: 100),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _xPosition = 45.0;
                          _yPosition = 80.0;
                          check = true;
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
                          FutureBuilder(
                              future: api.postRecomment(
                                  [weather.outlook], [temperature], [level], [reputation]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Visibility(
                                    visible: check,
                                    child: Stack(children: [
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[
                                          50], // set background color
                                          borderRadius: BorderRadius.circular(
                                              5.0), // set border radius
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data!.prediction! == "yes" && stadiums.length >0
                                                ? "Hãy thi đấu với đội bóng này hôm nay đi vì hôm nay trời ${txtOutlook} và nhiệt độ hiện tại sân là ${weather.temperature}°C - độ tin cậy ${(double.parse(snapshot.data!.accuracy!) * 100).toStringAsFixed(2)}% - Có các sân trống sau: ${stadiums}"
                                                : "Không nên thi đấu với đội bóng này vì hôm nay trời ${txtOutlook} và nhiệt độ hiện tại sân là ${weather.temperature}°C - độ tin cậy ${(double.parse(snapshot.data!.accuracy!) * 100).toStringAsFixed(2)}%",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0),
                                          ),
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
                                              check = false;
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
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              })
                        ],
                      ),
                    ),
                  ):Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(

                    ),
                  ),
                  //Positioned(child: SizedBox(height: 10,))

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
