import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';

class DetailDialog extends StatefulWidget {
  final String username;


  DetailDialog({
    required this.username,

  });

  @override
  _DetailDialogState createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  bool check = false;
  bool check1 = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchMomo() async {
    final String scheme = Platform.isAndroid ? 'market://' : 'itms-apps://';
    final String appId = 'com.mservice.momotransfer';
    final String url = '$scheme$appId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AlertDialog(
        //contentPadding: EdgeInsets.all(50),
        title: Center(child: Text("Chi tiết đội bóng")),
        content: Container(
          margin: EdgeInsets.only(bottom: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chọn phương thức thanh toán"),
                Row(
                  children: [
                    TextButton(
                        onPressed: () => {
                          setState(() {
                            check = true;
                            check1 = false;
                          })
                        },
                        child: Text("Thanh toán momo")),
                    TextButton(
                        onPressed: () => {
                          setState(() {
                            check = false;
                            check1 = true;
                          })
                        },
                        child: Text("Thanh toán banking"))
                  ],
                ),

              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {

             /* var data = {
                'starttime': widget.startTime,
                'endtime': widget.endTime,
                'm_stadium': widget.nameStadium
              };
              api.createOrder(data).then((value) {
                if (value) {
                  Fluttertoast.showToast(
                      msg: "Đã đặt sân, vui lòng đợi xác nhận",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else {
                  Fluttertoast.showToast(
                      msg: "Không thể đặt sân",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
              Future.delayed(const Duration(seconds: 0)).then((value) async {
                Get.offAllNamed('/home');
              });*/
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
