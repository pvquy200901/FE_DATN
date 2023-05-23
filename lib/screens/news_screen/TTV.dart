import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/screens/news_screen/postNews.dart';
import 'package:untitled/screens/news_screen/postTTV.dart';

import '../../config/app_config.dart';
import '../../utils/constants.dart';
import 'actionBtn.dart';
import 'driver.dart';
import 'feedbox.dart';
import 'news_controller.dart';

class TTVPage extends StatefulWidget {

  const TTVPage(
      {Key? key,})
      : super(key: key);
  @override
  _TTVPageState createState() => _TTVPageState();
}
class _TTVPageState extends State<TTVPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGrey,
      //let's add the app bar
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, // Màu sắc của biểu tượng "back"
        ),
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
        title: Text(
          "QDN Football",
          style: TextStyle(
            color: fbBlue,
          ),
        ),
        //Now let's add the action button
        actions: [
          Container(
            width: 100,
            height: 70,
            child: Image.asset("assets/images/LOGO_QDN.png"),
          ),
        ],
      ),
      //Now let's work on the body
      body: SingleChildScrollView(
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
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(
                                            snapshot.data!.avatar!.isEmpty ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU" : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.avatar!}")
                                    );
                                  }
                                  else{
                                    return CircularProgressIndicator();
                                  }
                                }),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.transparent),
                                      ),
                                    ),

                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return new createTTV();
                                        }));
                                  },
                                  child: Text('Tạo yêu cầu tuyển thành viên',textAlign: TextAlign.left, style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                )
                            ),
                          ]),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: mainGrey,
                        thickness: 0.5,
                      ),
                      //Now we will create a Row of three button
                      Row(
                        children: [
                          actionButton(context, Icons.people,
                              "Tuyển thành viên", Color(0xFFF23E5C),""),
                          actionButton(context, Icons.sports_soccer,
                              "Tìm trận đấu", Color(0xFF58C472),""),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FutureBuilder(
                  future: api.getListAction("TTV"),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Column(children: [
                        for (int i = 0; i < snapshot.data!.length; i++)
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: feedBox(context, snapshot.data![i].user!, snapshot.data![i].des!, snapshot.data![i].time!, snapshot.data![i].createTime!, snapshot.data![i].team!)
                          )
                      ]);
                    }
                    else{
                      return Container(

                        width: 100,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    }

                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget feedBox(BuildContext context,String userName, String des, String time,
      String createTime,String code) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: mainBlack,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),



                ),
                /*Text(
                  "Độ uy tín: " + point.toString(),
                  style: TextStyle(
                    color: mainBlack,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),



                ),*/
              ],
            ),
            SizedBox(height: 10,),

            Text(
              des,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Text(
              "Vào ngày:" + time,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 230),
              child: Text(
                createTime,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
            divider(0.5),

            Row(
              children: [
                actionButton(context, Icons.add_task, "Xem đội", Colors.blue, code),
              ],
            )
          ],
        ),
      ),
    );
  }
}
