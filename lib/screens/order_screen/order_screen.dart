import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/order_screen/info_order.dart';
import 'package:untitled/screens/splash_screen/splash_screen.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import '../../model/order_model/list_model.dart';
import '../../model/stadium_model/stadium_model.dart';

class OrderStadium extends StatefulWidget {
  final String name;
  const OrderStadium({Key? key, required this.name}): super(key: key);

  @override
  _OrderStadiumState createState() => _OrderStadiumState();
}
class _OrderStadiumState extends State<OrderStadium> {
  String name = "";
  String timeStart = "";
  DateTime _selectedDate = DateTime.now();
  bool checkDate = false;
  bool checkHour = false;
  bool checkButton = false;
  RxBool isLoading = false.obs;

  @override
  void initState(){
    super.initState();
    name = widget.name;
    loadData();
  }

  Stadium infoStadium = Stadium();

  loadData()async{
    isLoading.value = true;
    infoStadium = await api.getInfoStadium(name);
    isLoading.value = false;
    //orders = await api.getListOrderAllTime(DateFormat("MM/dd/yyyy").format(_selectedDate).toString());
    setState(() {

    });
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading.value ? CircularProgressIndicator() : Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 380,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(infoStadium.images!.isEmpty?"https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/97/5a/2d/discovering-the-state.jpg?w=1200&h=-1&s=1" : "http://${AppConfig.IP}:50000/api/File/image/${infoStadium.images![0]}"
                    ),
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
                      Text(
                        "Chọn ngày",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _choseDate(),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Chọn khung giờ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _choseTime(),
                      SizedBox(
                        height: 30,
                      ),
                      _buttonOrder(),

                    ],
                  ),
                  padding:
                  EdgeInsets.only(left: 25, right: 25, top: 37),
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

  _choseDate(){
    return  Container(
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color.fromARGB(
            255, 28, 159, 226),
        onDateChange: (date){
          _selectedDate = date;
          setState(() {
            checkHour = false;
          });
           //print(DateFormat('dd/MM/yyyy').format(_selectedDate));
        },
      ),
    );
  }
  _buttonOrder(){
    return  Visibility(
      visible: checkHour == true?true:false,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new InfoOrder(name: infoStadium.name!, dateOrder:DateFormat('dd/MM/yyyy').format(_selectedDate) , startTime: timeStart, address: infoStadium.address!, price: infoStadium.price!,);
              }));
            },
            child: Center(
              child: Text(
                "Đặt sân",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(
                      255, 255, 255, 255),
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _choseTime(){
    return   Center(
      child: Container(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          runSpacing: 8.0,
          children: [
            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "07:00") {
                      return itemTime("07:00","08:30",false);
                    }
                  }
                  return itemTime("07:00","08:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "08:30") {
                      return itemTime("08:30","10:00",false);
                    }
                  }
                  return itemTime("08:30","10:00",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "10:00") {
                      return itemTime("10:00","11:30",false);
                    }
                  }
                  return itemTime("10:00","11:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "12:00") {
                      return itemTime("12:00","13:30",false);
                    }
                  }
                  return itemTime("12:00","13:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "13:30") {
                      return itemTime("13:30","15:00",false);
                    }
                  }
                  return itemTime("13:30","15:00",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "15:00") {
                      return itemTime("15:00","16:30",false);
                    }
                  }
                  return itemTime("15:00","16:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "16:30") {
                      return itemTime("16:30","18:00",false);
                    }
                  }
                  return itemTime("16:30","18:00",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "18:00") {
                      return itemTime("18:00","19:30",false);
                    }
                  }
                  return itemTime("18:00","19:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "19:30") {
                      return itemTime("19:30","21:00",false);
                    }
                  }
                  return itemTime("19:30","21:00",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            FutureBuilder(
              future:
              api.getListOrderAllTime(DateFormat('dd/MM/yyyy').format(_selectedDate).toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0;
                  i < snapshot.data!.length;
                  i++) {
                    if (snapshot.data![i].time ==
                        "21:00") {
                      return itemTime("21:00","22:30",false);
                    }
                  }
                  return itemTime("21:00","22:30",true);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget itemTime(String startTime, String endTime, bool check){
    return  Visibility(
      visible: check,
      child: Container(
        width: 132,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 28, 159, 226),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  setState((){
                    timeStart = startTime;
                    checkHour = true;
                  });
                  //print(DateFormat("MM/dd/yyyy").format(_selectedDate).toString() + startTime);
                },
                child: Row(
                  children: [
                    Text(startTime),
                    Text(" - "),
                    Text(endTime),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}



