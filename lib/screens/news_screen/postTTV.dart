import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled/api/api.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'dart:math' as math;
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';


import '../user_screen/user_screen.dart';
import 'news_screen.dart';

class createTTV extends StatefulWidget {
  const createTTV({Key? key}) : super(key: key);

  @override
  State<createTTV> createState() => _createTTVState();

}

class _createTTVState extends State<createTTV> {

  DateTime _selectedDate = DateTime.now();
  String time = "";
  final TextEditingController desTxt = TextEditingController();


  Widget inputField(String hint, IconData iconData,
      TextEditingController _controller, String checked) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            controller: _controller,
            textAlignVertical: TextAlignVertical.bottom,
            obscureText: (hint.compareTo("Mật khẩu") == 0) ? true : false,
            onTap: () async {

            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          api.createAction(desTxt.text, time,"TTV").then((value) {
            if (value) {
              Fluttertoast.showToast(
                  msg: "Đã tạo bài tuyển thành viên thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewsPage();
              }));
            } else {
              Fluttertoast.showToast(
                  msg: "Không thể tạo đội bóng",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });


        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20 ),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài viết", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Color(0xFF3E80DA),Color(0xC77AA3E5)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            inputField("Viết miêu tả", Ionicons.help_outline, desTxt,""),
            Text("Thời gian duyệt "),
            DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color.fromARGB(
                  255, 28, 159, 226),
              onDateChange: (date){
                _selectedDate = date;
                 setState(() {
                   time = DateFormat('dd-MM-yyyy HH:mm').format(_selectedDate);
                });
                //print(time);
              },
            ),

            loginButton('Tạo bài viết'),
          ],
        ),
      ),
    );
  }
}