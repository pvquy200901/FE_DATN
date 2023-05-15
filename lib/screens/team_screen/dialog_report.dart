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

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    bool checkboxValue1 = true;
    bool checkboxValue2 = true;
    bool checkboxValue3 = true;
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
                    });
                  },
                  title: const Text('Headline'),
                  subtitle: const Text('Supporting text'),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: checkboxValue2,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue2 = value!;
                    });
                  },
                  title: const Text('Headline'),
                  subtitle: const Text(
                      'Longer supporting text to demonstrate how the text wraps and the checkbox is centered vertically with the text.'),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: checkboxValue3,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue3 = value!;
                    });
                  },
                  title: const Text('Headline'),
                  subtitle: const Text(
                      "Longer supporting text to demonstrate how the text wraps and how setting 'CheckboxListTile.isThreeLine = true' aligns the checkbox to the top vertically with the text."),
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
             /* api.createOrder(data).then((value) {
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
