/*import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/order_screen/info_order.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
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
  String timeEnd = "";
  DateTime _selectedDate = DateTime.now();
  bool checkDate = false;
  bool checkHour = false;
  bool checkButton = false;
  RxBool isLoading = false.obs;
  Color _clipRRectColor = const Color.fromARGB(255, 255, 255, 255);

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
                      Center(child: _choseTime(),),

                      SizedBox(
                        height: 30,
                      ),
                      Center(child: _buttonOrder(),),

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
                String code = _selectedDate.day.toString()+_selectedDate.month.toString()+_selectedDate.year.toString()+infoStadium.name! +timeStart;
                return new InfoOrder(name: infoStadium.name!, dateOrder:DateFormat('dd/MM/yyyy').format(_selectedDate) , startTime: timeStart,endTime: timeEnd, address: infoStadium.address!, price: infoStadium.price!, code: code,);
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
              api.getListOrderUser(DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),name),
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
        width: 150,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 28, 159, 226),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: _clipRRectColor,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 18),

                ),
                onPressed: () {
                  setState((){
                    timeStart = startTime;
                    timeEnd = endTime;
                    checkHour = true;

                  });
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
}*/

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/order_screen/info_order.dart';

import '../../api/api.dart';
import '../../config/app_config.dart';
import 'package:simple_item_selector/simple_item_selector.dart';
import '../../model/order_model/list_model.dart';
import '../../model/stadium_model/stadium_model.dart';

class OrderStadium extends StatefulWidget {
  final String name;
  const OrderStadium({Key? key, required this.name}) : super(key: key);

  @override
  _OrderStadiumState createState() => _OrderStadiumState();
}

class _OrderStadiumState extends State<OrderStadium> {
  String name = "";
  String timeStart = "";
  String timeEnd = "";
  DateTime _selectedDate = DateTime.now();
  bool checkDate = false;
  bool checkHour = false;
  bool checkButton = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    loadData();
  }

  Stadium infoStadium = Stadium();
  List<itemOrder> listOrder = [];
  List<Widget> mWidget = [];
  loadData() async {
    setState(() {
      isLoading = true;
    });
    infoStadium = await api.getInfoStadium(name);
    listOrder = await api.getListOrderUser(
        DateFormat('dd/MM/yyyy').format(_selectedDate).toString(), name);

    setState(() {
      isLoading = false;
    });
    mWidget.add(itemTime("07:00", "08:30", true));
    mWidget.add(itemTime("08:30", "10:00", true));
    mWidget.add(itemTime("10:00", "11:30", true));
    mWidget.add(itemTime("12:00", "13:30", true));
    mWidget.add(itemTime("13:30", "15:00", true));
    mWidget.add(itemTime("15:00", "16:30", true));
    mWidget.add(itemTime("16:30", "18:00", true));
    mWidget.add(itemTime("18:00", "19:30", true));
    mWidget.add(itemTime("19:30", "21:00", true));
    mWidget.add(itemTime("21:00", "22:30", true));
    for (int i = 0; i < listOrder.length; i++) {
      if (listOrder[i].time!.compareTo("07:00") == 0) {
        mWidget.removeAt(0);
      } else if (listOrder[i].time!.compareTo("08:30") == 0) {
        mWidget.removeAt(1);
      } else if (listOrder[i].time!.compareTo("10:00") == 0) {
        mWidget.removeAt(2);
      } else if (listOrder[i].time!.compareTo("12:00") == 0) {
        mWidget.removeAt(3);
      } else if (listOrder[i].time!.compareTo("13:30") == 0) {
        mWidget.removeAt(4);
      } else if (listOrder[i].time!.compareTo("15:00") == 0) {
        mWidget.removeAt(5);
      } else if (listOrder[i].time!.compareTo("16:30") == 0) {
        mWidget.removeAt(6);
      } else if (listOrder[i].time!.compareTo("18:00") == 0) {
        mWidget.removeAt(7);
      } else if (listOrder[i].time!.compareTo("19:30") == 0) {
        mWidget.removeAt(8);
      } else if (listOrder[i].time!.compareTo("21:00") == 0) {
        mWidget.removeAt(9);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const CircularProgressIndicator()
            : Stack(
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
                            child: const Center(
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
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                        const SizedBox(
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
                        padding: const EdgeInsets.only(left: 25, right: 25, top: 37),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Chọn ngày",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'RobotoMono',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _choseDate(),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              "Chọn khung giờ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'RobotoMono',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: _choseTime(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: _buttonOrder(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _choseDate() {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: const Color.fromARGB(255, 28, 159, 226),
      onDateChange: (date) {
        _selectedDate = date;
        setState(() {
          checkHour = false;
        });
        //print(DateFormat('dd/MM/yyyy').format(_selectedDate));
      },
    );
  }

  _buttonOrder() {
    return Visibility(
      visible: checkHour == true ? true : false,
      child: Container(
        height: 48,
        width: 325,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 159, 226),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    infoStadium.name! +
                    timeStart;
                return InfoOrder(
                  name: infoStadium.name!,
                  dateOrder: DateFormat('dd/MM/yyyy').format(_selectedDate),
                  startTime: timeStart,
                  endTime: timeEnd,
                  address: infoStadium.address!,
                  price: infoStadium.price!,
                  code: code,
                );
              }));
            },
            child: const Center(
              child: Text(
                "Đặt sân",
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

  _choseTime() {
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 8.0,
        children: [
          ItemSelector(
            direction: Direction.vertical,
            activeBackgroundColor: Colors.amberAccent,
            inactiveBackgroundColor: Colors.grey[300],
            initIndex: -1,
            itemMargin: const EdgeInsets.all(2.0),
            itemPadding: const EdgeInsets.all(15.0),
            itemBorderRadius: const BorderRadius.all(Radius.circular(5.0)),
            itemsCount: 10, //mWidget.length, // should be <= items.length
            items: //mWidget,
                [
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "07:00") {
                        return itemTime("07:00", "08:30", false);
                      }
                    }
                    return itemTime("07:00", "08:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "08:30") {
                        return itemTime("08:30", "10:00", false);
                      }
                    }
                    return itemTime("08:30", "10:00", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "10:00") {
                        return itemTime("10:00", "11:30", false);
                      }
                    }
                    return itemTime("10:00", "11:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "12:00") {
                        return itemTime("12:00", "13:30", false);
                      }
                    }
                    return itemTime("12:00", "13:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "13:30") {
                        return itemTime("13:30", "15:00", false);
                      }
                    }
                    return itemTime("13:30", "15:00", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "15:00") {
                        return itemTime("15:00", "16:30", false);
                      }
                    }
                    return itemTime("15:00", "16:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "16:30") {
                        return itemTime("16:30", "18:00", false);
                      }
                    }
                    return itemTime("16:30", "18:00", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "18:00") {
                        return itemTime("18:00", "19:30", false);
                      }
                    }
                    return itemTime("18:00", "19:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "19:30") {
                        return itemTime("19:30", "21:00", false);
                      }
                    }
                    return itemTime("19:30", "21:00", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: api.getListOrderUser(
                    DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
                    name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].time == "21:00") {
                        return itemTime("21:00", "22:30", false);
                      }
                    }
                    return itemTime("21:00", "22:30", true);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ], // any arbitrary widget list
            onSelected: (index) {
              if (index == 0) {
                setState(() {
                  timeStart = "07:00";
                  timeEnd = "08:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 1) {
                setState(() {
                  timeStart = "08:30";
                  timeEnd = "10:00";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 2) {
                setState(() {
                  timeStart = "10:00";
                  timeEnd = "11:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 3) {
                setState(() {
                  timeStart = "12:00";
                  timeEnd = "13:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 4) {
                setState(() {
                  timeStart = "13:30";
                  timeEnd = "15:00";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 5) {
                setState(() {
                  timeStart = "15:00";
                  timeEnd = "16:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 6) {
                setState(() {
                  timeStart = "16:30";
                  timeEnd = "18:00";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 7) {
                setState(() {
                  timeStart = "18:00";
                  timeEnd = "19:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else if (index == 8) {
                setState(() {
                  timeStart = "19:30";
                  timeEnd = "21:00";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              } else {
                setState(() {
                  timeStart = "21:00";
                  timeEnd = "22:30";
                  checkHour = true;
                });
                String code = _selectedDate.day.toString() +
                    _selectedDate.month.toString() +
                    _selectedDate.year.toString() +
                    timeEnd +
                    timeStart;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget itemTime(String startTime, String endTime, bool check) {
    return Center(
      child: SizedBox(
        width: 90,
        child: check == false
            ? const Text("Đã được đặt")
            : Row(
                children: [
                  Text(startTime),
                  const Text(" - "),
                  Text(endTime),
                ],
              ),
      ),
    );
  }
}
