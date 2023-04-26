
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/model/chat_model/chatModel.dart';
import 'package:untitled/model/user_model/user_model.dart';

import '../../../api/api.dart';

class ShowMessages extends StatefulWidget {
  final String m_team;
  final String m_user;
  const ShowMessages({
    Key? key,
    required this.m_team,
    required this.m_user,
  }) : super(key: key);

  @override
  State<ShowMessages> createState() => _ShowMessagesState();
}

class _ShowMessagesState extends State<ShowMessages> {

  bool isLoading =false;
  late String team;
  late String user;
  @override
  void initState() {
    setState(() {
      isLoading = true;
      team = widget.m_team;
      user = widget.m_user;
    });
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return FutureBuilder(
          future: api.getListAllChat(team),
          builder:((context, snapshot)  {
            if (snapshot.hasData) {
              List<Chat> list = snapshot.data!;
              return ListView.builder(
                  reverse: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment:
                      (list[index].userComment == user)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: (list[index].userComment == user)
                                  ? Color(0xff2865DC)
                                  : Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  (list[index].userComment == user)
                                      ? Color(0xffE4E9F6)
                                      : Color(0xffE1E1E1),
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.normal,
                                  offset: Offset(0, 4),
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (list[index].chat
                                  .toString()
                                  .isNotEmpty)
                                  ? Text(
                                list[index].chat!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: (list[index].userComment == user)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )
                                  : GestureDetector(
                                onTap: () {

                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    list[index].time!,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                      color: (list[index].userComment == user)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  (list[index].userComment == user)
                                      ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: (list[index].userComment == user)
                                        ? Colors.white
                                        : Colors.black,
                                  )
                                      : Text(""),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
    }
  }
}