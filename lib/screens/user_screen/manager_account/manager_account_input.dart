import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled/api/api.dart';
import 'package:untitled/controller/app_controller.dart';
import 'dart:math' as math;
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';

import '../user_screen.dart';

class InputAccount extends StatefulWidget {
  const InputAccount({Key? key}) : super(key: key);

  @override
  State<InputAccount> createState() => _InputAccountState();
}

class _InputAccountState extends State<InputAccount> {
  final TextEditingController birthdayTxt = TextEditingController();
  final TextEditingController nameTxt = TextEditingController();
  final TextEditingController phoneTxt = TextEditingController();
  final TextEditingController emailTxt = TextEditingController();

  Widget inputField(String hint, IconData iconData,
      TextEditingController _controller, String checked) {
    _controller.text = hint;
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
            keyboardType: check(checked),
            onTap: () async {
              if (checked.compareTo("Ngày sinh") == 0) {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('MM/dd/yyyy').format(pickedDate);
                  setState(() {
                    birthdayTxt.text = formattedDate;
                  });
                } else {}
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              //hintText: hint,
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
          var data = {
            "name": nameTxt.text,
            "birthday": birthdayTxt.text,
            "email": emailTxt.text,
            "phone": phoneTxt.text
          };
          api.updateUser(data).then((value) {
            if (value) {
              Fluttertoast.showToast(
                  msg: "Đã cập nhật thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Get.back();
            } else {
              Fluttertoast.showToast(
                  msg: "Không thể cập nhật",
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
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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

  TextInputType check(hint) {
    if ((hint.compareTo("Số điện thoại") == 0)) {
      return TextInputType.number;
    }
    if ((hint.compareTo("Ngày sinh") == 0)) {
      return TextInputType.none;
    }
    return TextInputType.text;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getInfoUserV2(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              inputField(snapshot.data!.name.toString(),
                  Ionicons.person_outline, nameTxt, ""),
              inputField(snapshot.data!.email.toString(), Ionicons.mail_outline,
                  emailTxt, ""),
              inputField(snapshot.data!.phone.toString(),
                  Ionicons.phone_landscape_outline, phoneTxt, "Số điện thoại"),
              inputField(snapshot.data!.birthday.toString(),
                  Ionicons.calendar_number_outline, birthdayTxt, "Ngày sinh"),
              loginButton('Cập nhật'),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
