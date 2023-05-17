import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';

class ReportDialog extends StatefulWidget {
  final String nameStadium;
  ReportDialog({
    required this.nameStadium,
  });
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checked = false;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AlertDialog(
        //contentPadding: EdgeInsets.all(50),
        title: Center(child: Text("Tố cáo đội " + widget.nameStadium)),
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
               Text("Lý do"),
                CheckboxListTile(
                  value: checkboxValue1,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue1 = value!;
                      checked = true;
                    });
                  },
                  title: const Text('Cúp kèo'),
                  subtitle: const Text('Hẹn đấu nhưng không tới'),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: checkboxValue2,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue2 = value!;
                      checked = true;
                    });
                  },
                  title: const Text('Chơi xấu'),
                  subtitle: const Text(
                      'Thường xuyên vào bóng với ý đồ ác'),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: checkboxValue3,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue3 = value!;
                      checked = true;
                    });
                  },
                  title: const Text('Xúc phạm'),
                  subtitle: const Text(
                      "Ngôn từ gây xúc phạm, hiểu nhầm ác ý"),
                  isThreeLine: true,
                ),
                const Divider(height: 0),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if(checked == false){
                Fluttertoast.showToast(
                    msg: "Vui lòng chọn lý do",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP_RIGHT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              api.reportTeam(widget.nameStadium).then((value) {
                if (value) {
                  Fluttertoast.showToast(
                      msg: "Đã tố cáo thành công",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                else {
                  Fluttertoast.showToast(
                      msg: "Không thể tố cáo",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });

              Future.delayed(
                  const Duration(seconds: 0))
                  .then((value) async {
                Get.back();
                Get.back();
              });
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
