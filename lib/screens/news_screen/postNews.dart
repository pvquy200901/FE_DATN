import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../../api/api.dart';
import '../../config/app_config.dart';
import 'package:http_parser/http_parser.dart';

import '../../dashboard/dashboard_page.dart';

class PostNews extends StatefulWidget {
  @override
  _PostNewsState createState() => _PostNewsState();
}

class _PostNewsState extends State<PostNews> {
  double _extraBottomPadding = 0;
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late dio.FormData m_data;
  Future<PickedFile?> pickedFile = Future.value(null);
  XFile? m_image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tạo bài đăng",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                ),
              ),
             Row(
               children: [
                 IconButton(onPressed: () async{
                   m_image = await _picker.pickImage(source: ImageSource.gallery);
                   if (m_image != null) {
                     final bytes = await m_image!.readAsBytes();
                     var dataImage = dio.MultipartFile.fromBytes(bytes,
                         filename: m_image!.name,
                         );
                     dio.FormData data =
                     dio.FormData.fromMap({'image': dataImage});
                     setState(() {
                       m_data = data;
                     });
                   }
                 }, icon: Icon(Icons.image),color: Colors.black,),
                  InkWell(
                onTap: () {
                  api.createNews(_textEditingController.text, _textEditingController.text, _textEditingController.text, m_data).then((value) => {
                        if (value)
                          {
                            Future.delayed(const Duration(seconds: 0))
                                .then((value) async {
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => DashboardPage(index: 2,),
                                ),
                              );
                            }),
                            Fluttertoast.showToast(
                                msg:
                                    "Đăng bài thành công, vui lòng đợi admin duyệt bài!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.blueAccent,
                                textColor: Colors.black,
                                fontSize: 16.0)
                          }
                        else
                          {
                            Fluttertoast.showToast(
                                msg: "Đăng bài thất bại!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                          }
                      });
                },
                child: Text(
                  "Đăng",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              )
               ],
             )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  _extraBottomPadding,
            ),
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
                                backgroundImage: NetworkImage(snapshot
                                        .data!.avatar!.isEmpty
                                    ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrT9QfTWesZk1IklGxsaH7hioyMTC7oLyTYg&usqp=CAU"
                                    : "http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.avatar!}"));
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Phan Vũ Quý",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (text) {
                    setState(() {
                      // calculate extra bottom padding needed to push the content up
                      _extraBottomPadding =
                          MediaQuery.of(context).viewInsets.bottom;
                    });
                  },
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: "Hãy đăng bài...",
                    filled: true,
                    fillColor: Colors.transparent,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
