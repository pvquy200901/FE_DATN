import 'package:flutter/material.dart';

import '../../api/api.dart';

class PaymentDialog extends StatefulWidget {
  final String code;

  PaymentDialog(
      {required this.code,
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
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Text("Chọn phương thức thanh toán"),
                Row(
                  children: [
                    TextButton(onPressed: () =>{

                    setState(() {
                      check = true;
                      check1 = false;
                    })
                    }, child: Text("Thanh toán momo")),
                    TextButton(onPressed: () =>{
                      setState(() {
                        check = false;
                        check1 = true;
                      })
                    }, child: Text("Thanh toán banking"))
                  ],

                ),
                Visibility(
                  visible: check,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Số tiền: 50000d"),
                        Text("Số điện thoại: 0913136242"),
                        Text("Nội dung: ${widget.code}"),
                        TextButton(onPressed: () => {

                        }, child: Text("Bấm vào để mở MOMO")),
                        Text("Lưu ý"),
                        Text("Vui lòng nhập chính xác nội dung và số tiền yêu cầu từ hệ thống; Thông tin không chính xác sẽ ảnh hưởng tới việc đặt sân")
                      ],
                    )),
                Visibility(
                  visible:  check1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Số tiền: 50000d"),
                          Text("Tên ngân hàng: Ngân hàng Quân đội"),
                          Text("Tên người nhận: Phan Vũ Quý"),
                          Text("Số tài khoản: 0913136242"),
                          Text("Nội dung: ${widget.code}"),
                          TextButton(onPressed: () => {

                          }, child: Text("Bấm vào để mở MBBank")),
                          Text("Lưu ý"),
                          Text("Vui lòng nhập chính xác nội dung và số tiền yêu cầu từ hệ thống; Thông tin không chính xác sẽ ảnh hưởng tới việc đặt sân")
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
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
