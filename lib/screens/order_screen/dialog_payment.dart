import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';

class PaymentDialog extends StatefulWidget {
  final String code;
  final String startTime;
  final String endTime;
  final String nameStadium;
  final String price;

  PaymentDialog({
    required this.code,
    required this.startTime,
    required this.endTime,
    required this.nameStadium,
    required this.price,
  });

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
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
        title: Center(child: Text("Thanh toán online")),
        content: Container(
          margin: EdgeInsets.only(bottom: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chọn phương thức thanh toán"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => {
                              setState(() {
                                check = true;
                                check1 = false;
                              })
                            },
                        child: Text("Momo")),
                    TextButton(
                        onPressed: () => {
                              setState(() {
                                check = false;
                                check1 = true;
                              })
                            },
                        child: Text("Banking"))
                  ],
                ),
                Visibility(
                    visible: check,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Số tiền: ${widget.price}"),
                        Text("Số điện thoại: 0913136242"),
                        Text("Nội dung: ${widget.code}"),
                        TextButton(
                            onPressed: () => {print("đã bấm"), launch("momo://")},
                            child: Text("Bấm vào để mở MOMO")),
                        Text("Lưu ý"),
                        Text(
                            "Vui lòng nhập chính xác nội dung và số tiền yêu cầu từ hệ thống; Thông tin không chính xác sẽ ảnh hưởng tới việc đặt sân")
                      ],
                    )),
                Visibility(
                    visible: check1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Số tiền: ${widget.price}"),
                          Text("Tên ngân hàng: Ngân hàng Quân đội"),
                          Text("Tên người nhận: Phan Vũ Quý"),
                          Text("Số tài khoản: 0913136242"),
                          Text("Nội dung: ${widget.code}"),
                          TextButton(
                              onPressed: () => {print("đã bấm"), launch("mbbank://")},
                              child: Text("Bấm vào để mở MBBank")),
                          Text("Lưu ý"),
                          Text(
                              "Vui lòng nhập chính xác nội dung và số tiền yêu cầu từ hệ thống; Thông tin không chính xác sẽ ảnh hưởng tới việc đặt sân")
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();

            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {

              var data = {
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
              });
            },
            child: Text('OK'),
          ),

        ],
      ),
    );
  }
}
