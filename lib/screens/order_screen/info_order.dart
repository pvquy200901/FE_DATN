import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../model/order_model/list_model.dart';
import '../../model/stadium_model/stadium_model.dart';
import 'dialog_payment.dart';

class InfoOrder extends StatefulWidget {
  final String name;
  final String dateOrder;
  final String startTime;
  final String address;
  final String code;
  final int price;
  const InfoOrder(
      {Key? key,
      required this.name,
      required this.dateOrder,
      required this.startTime,
      required this.address,
      required this.price,
      required this.code})
      : super(key: key);

  @override
  _InfoOrderState createState() => _InfoOrderState();
}

class _InfoOrderState extends State<InfoOrder> {
  String name = "";
  String dateOrder = "";
  String startTime = "";
  String address = "";
  int price = 0;
  bool isLoading = false;
  Stadium infoStadium = Stadium();



  loadData() async {
    setState(() {
      isLoading = true;
    });
    infoStadium = await api.getInfoStadium(name);
    //orders = await api.getListOrderAllTime(DateFormat("MM/dd/yyyy").format(_selectedDate).toString());
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    name = widget.name;
    startTime = widget.startTime;
    address = widget.address;
    dateOrder = widget.dateOrder;
    price = widget.price;
    loadData();
  }




  @override
  Widget build(BuildContext context) {
    return (isLoading)? CircularProgressIndicator(): SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 380,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(infoStadium.images!.isEmpty
                        ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1"
                        : "http://${AppConfig.IP}:50000/api/File/image/${infoStadium.images![0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: 44,
              left: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          size: 18,
                          Icons.keyboard_arrow_left_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    infoStadium.name!,
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                  SizedBox(
                    width: 45,
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 380 - 110,
              bottom: 0,
              // bottom: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Chi tiết lịch đặt sân",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Column(
                          children: [
                            info("Ngày đặt sân", dateOrder),
                            info("Giờ bắt đầu", startTime),
                            info("Số giờ thuê", "01:30:00"),
                            info("Địa chỉ sân", address),
                            info("Giá sân", price.toString() + "VNĐ"),
                            info("Tổng tiền", (price * 1.5).toString() + "VNĐ"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      _buttonOrder(),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 25, right: 25, top: 37),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoMono',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoMono',
            ),
          )
        ],
      ),
    );
  }

  _buttonOrder() {
    return Visibility(
      visible: true,
      child: Container(
        height: 48,
        width: 325,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 28, 159, 226),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {
              showDialog(context: context, builder: (BuildContext context){
                return PaymentDialog(code: widget.code,);
              });
            },
            child: Center(
              child: Text(
                "Thanh toán",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
