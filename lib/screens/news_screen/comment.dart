import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/news_model/news_model.dart';
import 'package:untitled/model/weather_model/weather_model.dart';
import 'package:untitled/screens/news_screen/driver.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../model/comment_model/comment_model.dart';
import '../../model/team_model/team_model.dart';
import '../../model/user_model/user_model.dart';
import '../../utils/constants.dart';

class Comments extends StatefulWidget {
  final String code;
  Comments({Key? key, required this.code}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  String outlook = "";
  String temperature = "";
  String level ="";
  String reputation = "";
  String txtOutlook = "";
  bool check = false;
  infoNews news = infoNews();
  infoUser user = infoUser();
  Team team = Team();
  WeatherData weather = WeatherData();
  List<listComments> comments = [];
  double _xPosition = 280.0;
  double _yPosition = 80.0;
  double latitude = 10.88283465113124;
  double longitude = 106.78173797251489;
  String m_team = "";

  loadData() async {
    setState(() {
      isLoading = true;
    });
    news = await api.getInfoNewsForCustomer(widget.code);
    user = await api.getInfoUserV2();
    comments = await api.getListCommentsInNews(widget.code);
    team = await api.getInfoTeamOfUser(news.username);
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

    if (team.reputation! > 100 && team.reputation! <= 80) {
      reputation = "high";
    }
    if (team.reputation! > 80 && team.reputation! <= 50) {
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
    return SafeArea(
      child: isLoading
          ? Container(
              width: 100,
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Center(
                    child: Icon(
                      size: 25,
                      Icons.keyboard_double_arrow_left_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Bài viết của " + news.user!,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: kBackgroundColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                            radius: 25.0,
                                            backgroundImage: NetworkImage(user
                                                    .avatar!.isEmpty
                                                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU"
                                                : "http://${AppConfig.IP}:50000/api/File/image/${user.avatar!}")),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          news.user!,
                                          style: TextStyle(
                                            color: mainBlack,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Độ uy tín: ${team.reputation}",
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  news.description!,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                       /* (news
                                            .avatar!.isEmpty
                                            ? "https://static-images.vnncdn.net/files/publish/2022/11/7/world-cup-2022-1-707.jpg"
                                            : "http://${AppConfig.IP}:50000/api/File/image/${user.avatar!}")*/
                                      image: NetworkImage(
                                        (news
                                            .imagesNews![0].isEmpty
                                            ? "https://static-images.vnncdn.net/files/publish/2022/11/7/world-cup-2022-1-707.jpg"
                                            : "http://${AppConfig.IP}:50000/api/File/image/${news.imagesNews![0]}")),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Text(
                                  "${comments.length} Bình luận",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                divider(0.5),
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(user
                                                .avatar!.isEmpty
                                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU"
                                            : "http://${AppConfig.IP}:50000/api/File/image/${user.avatar!}")),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                        child: Stack(
                                      children: [
                                        TextFormField(
                                          controller: _textEditingController,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                              hintText: "Nhập bình luận...",
                                              filled: true,
                                              fillColor: Colors.black12,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide.none,
                                              )),
                                        ),
                                        Positioned(
                                          right: -10,
                                          child: TextButton(
                                            onPressed: () {
                                              api
                                                  .createComments(
                                                      widget.code,
                                                      _textEditingController
                                                          .text)
                                                  .then((value) => {
                                                        if (value)
                                                          {
                                                            Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            0))
                                                                .then(
                                                                    (value) async {
                                                              Navigator
                                                                  .pushReplacement<
                                                                      void,
                                                                      void>(
                                                                context,
                                                                MaterialPageRoute<
                                                                    void>(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      Comments(
                                                                    code: widget
                                                                        .code,
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                          }
                                                        else
                                                          {}
                                                      });
                                            },
                                            child: Icon(
                                              size: 25,
                                              Icons.send_sharp,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                SizedBox(height: 25),
                                for (int i = 0; i < comments.length; i++)
                                  itemComment(
                                      comments[i].avatarUser!.isEmpty
                                          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU"
                                          : "http://${AppConfig.IP}:50000/api/File/image/${comments[i].avatarUser!}",
                                      comments[i].userComment!,
                                      comments[i].comment!),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                        )
                      ],
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
                                [outlook], [temperature], [level], [reputation]),
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
                                          snapshot.data!.prediction! == "1"
                                              ? "Hãy thi đấu với đội bóng này hôm nay đi vì hôm nay trời ${txtOutlook} và nhiệt độ hiện tại là ${weather.temperature}°C- độ tin cậy ${double.parse(snapshot.data!.accuracy!) * 100}%"
                                              : "Không nên thi đấu với đội bóng này hôm nay trời ${txtOutlook} và nhiệt độ hiện tại là ${weather.temperature}°C- độ tin cậy ${double.parse(snapshot.data!.accuracy!) * 100}%",
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
                ),
              ]),
            ),
    );
  }
}

Widget itemComment(String avatar, String name, String comment) {
  return Column(
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(avatar
                //"https://img6.thuthuatphanmem.vn/uploads/2022/02/25/background-story-instagram-mau-hong_075510201.jpg"
                ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: mainBlack,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      comment,
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black12,
              ),
            ),
          ),
        ],
      ),
      divider(0.5),
    ],
  );
}
