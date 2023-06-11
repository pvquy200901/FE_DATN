import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/screens/news_screen/postTTD.dart';

import '../../config/app_config.dart';
import '../../model/action_model/action.dart';
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
  int index = 2;
  final TextEditingController code = TextEditingController();
  String text = "";

  List<mAction> actions = [];

  bool isLoading = false;
  loadingData() async {
    setState(() {
      isLoading = true;
    });
    if(text.compareTo("") == 0){
      actions = await api.getListAction("TTD");
    }
    else{
      actions = await api.searchingAction(text);
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
                  )
              ]),

            ],
          ),
        ),
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

}
