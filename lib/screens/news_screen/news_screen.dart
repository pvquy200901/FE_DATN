import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/screens/news_screen/postNews.dart';

import '../../config/app_config.dart';
import '../../utils/constants.dart';
import 'actionBtn.dart';
import 'feedbox.dart';
import 'news_controller.dart';

class NewsPage extends GetView<NewsController> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGrey,
      //let's add the app bar
      appBar: AppBar(
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
                                      return new PostNews();
                                    }));
                              },
                              child: Text('Hãy đăng bài...',textAlign: TextAlign.left, style: TextStyle(
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
                  future: api.getListNews(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Column(children: [
                        for (int i = 0; i < snapshot.data!.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: feedBox(context, snapshot.data![i].user!, int.parse(snapshot.data![i].reputation!), snapshot.data![i].createdTime!, snapshot.data![i].title!, "",snapshot.data![i].code!)
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
}
