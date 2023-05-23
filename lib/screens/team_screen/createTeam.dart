import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/controller/app_controller.dart';
import 'dart:math' as math;
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';


import '../user_screen/user_screen.dart';

class createTeam extends StatefulWidget {
  const createTeam({Key? key}) : super(key: key);

  @override
  State<createTeam> createState() => _createTeamState();

}

class _createTeamState extends State<createTeam> {

  final TextEditingController nameTxt = TextEditingController();
  final TextEditingController shortNameTxt = TextEditingController();
  final TextEditingController phoneTxt = TextEditingController();
  final TextEditingController desTxt = TextEditingController();
  final TextEditingController addressTxt = TextEditingController();
  final TextEditingController levelTxt = TextEditingController();

  String _selectedItem = "Giỏi";

  List<String> _dropdownItems = [
    'Giỏi',
    'Bình thường',
  ];
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

  Widget inputField2(String hint, IconData iconData,
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

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              labelText: 'Trình độ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(iconData),
              suffixIcon: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove bottom border
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                value: _selectedItem,
                onChanged: (newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
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
          var data = {
            "name": nameTxt.text,
            "shortName": shortNameTxt.text,
            "phone": phoneTxt.text,
            "des": desTxt.text,
            "address": addressTxt.text,
            "level": _selectedItem,
          };
          api.createTeam(data).then((value) {
            if (value) {
              Fluttertoast.showToast(
                  msg: "Đã tạo đội bóng thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserPage();
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
        title: Text("Tạo đội bóng", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
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
            inputField("Tên đội bóng", Ionicons.person, nameTxt,""),
            inputField("Tên viết tắt", Ionicons.text, shortNameTxt,""),
            inputField("Số điện thoại", Ionicons.phone_landscape_outline, phoneTxt,""),
            inputField("Miêu tả về đội bóng", Ionicons.help_outline, desTxt,""),
            inputField("Địa chỉ", Ionicons.location, addressTxt,""),
            inputField2("Trình độ", Ionicons.earth, levelTxt,""),
            loginButton('Tạo đội'),
          ],
        ),
      ),
    );
  }
}