import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled/api/api.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'dart:math' as math;
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';


import '../../model/order_model/list_model.dart';
import '../../model/stadium_model/stadium_model.dart';
import '../user_screen/user_screen.dart';
import 'news_screen.dart';

class createTTD extends StatefulWidget {
  const createTTD({Key? key}) : super(key: key);

  @override
  State<createTTD> createState() => _createTTDState();

}

class _createTTDState extends State<createTTD> {
  String selectedTime = "";
  String _dropDownValue ="";
  String name = "";
  List<itemOrder> listOrder = [];
  bool isLoading = false;

  DateTime _selectedDate = DateTime.now();
  String time = "";
  String lastTime = "";
  final TextEditingController desTxt = TextEditingController();
  List<Stadium> stadiums = [];
  List<String> m_stadiums = [];



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

  void dropDown(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _dropDownValue = selectedValue;
        loadData();
      });
    }
  }




  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 25),
      child: ElevatedButton(
        onPressed: () {
          api.createAction(desTxt.text, '${DateFormat('dd-MM-yyyy').format(_selectedDate)} ${selectedTime}',"TTD", _dropDownValue).then((value) {
            if (value) {
              Fluttertoast.showToast(
                  msg: "Đã tạo bài tìm trận đấu thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Get.back();
              Get.back();
            } else {
              Fluttertoast.showToast(
                  msg: "Không thể bài tìm trận đấu",
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();



loadData2() async {

  stadiums = await api.getListStadiumForCustomer();
  for(int i = 0; i < stadiums.length ; i ++){
    m_stadiums.add(stadiums[i].name!);
  }

  setState(() {
    _dropDownValue = m_stadiums.first;
  });
}
  loadData() async {
    setState(() {
      isLoading = true;
    });
    listOrder = await api.getListOrderUser(
        DateFormat('dd/MM/yyyy').format(_selectedDate).toString(), _dropDownValue);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    loadData2();
    loadData();
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
            SizedBox(
              height: 20,
            ),
            inputField("Viết miêu tả", Ionicons.help_outline, desTxt,""),
            SizedBox(
              height: 20,
            ),

            Text("Chọn sân:", style: TextStyle(fontSize: 16),),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: DropdownButton<String>(
                value: _dropDownValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: dropDown,
                items: m_stadiums.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Ngày có thể thi đấu ", style: TextStyle(fontSize: 16),),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now().subtract(Duration(days: 1)),
                selectionColor: Color.fromARGB(
                    255, 28, 159, 226),
                onDateChange: (date){
                  _selectedDate = date;
                  setState(() {
                    time = DateFormat('dd-MM-yyyy').format(_selectedDate);
                    loadData();
                  });
                  //print(time);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Chọn giờ có thể thi đấu ", style: TextStyle(fontSize: 16),),

            Wrap(
              direction: Axis.vertical,
              children:(listOrder.isEmpty)?[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "07:00";
                    });
                  },
                  child: Text('07:00'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "08:30";
                    });
                  },
                  child: Text('08:30'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "10:00";
                    });
                  },
                  child: Text('10:00'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "12:00";
                    });
                  },
                  child: Text('12:00'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "13:30";
                    });
                  },
                  child: Text('13:30'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "15:00";
                    });
                  },
                  child: Text('15:00'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "16:30";
                    });
                  },
                  child: Text('16:30'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "18:00";
                    });
                  },
                  child: Text('18:00'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "19:30";
                    });
                  },
                  child: Text('19:30'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTime = "21:00";
                    });
                  },
                  child: Text('21:00'),
                ),
              ]: [
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("07:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "07:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("07:00") == 0)?Text('Không thể chọn'):Text('07:00'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("08:30") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "08:30";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("08:30") == 0)?Text('Không thể chọn'):Text('08:30'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("10:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "10:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("10:00") == 0)?Text('Không thể chọn'):Text('10:00'),
                  ),

                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("12:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "12:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("12:00") == 0)?Text('Không thể chọn'):Text('12:00'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("13:30") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "13:30";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("13:30") == 0)?Text('Không thể chọn'):Text('13:30'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("15:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "15:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("15:00") == 0)?Text('Không thể chọn'):Text('15:00'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("16:30") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "16:30";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("16:30") == 0)?Text('Không thể chọn'):Text('16:30'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("18:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "18:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("18:00") == 0)?Text('Không thể chọn'):Text('18:00'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("19:30") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "19:30";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("19:30") == 0)?Text('Không thể chọn'):Text('19:30'),
                  ),
                for(int i = 0 ; i < listOrder.length; i++)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width - 100, 40),
                    ),
                    onPressed: () {
                      setState(() {
                        if(listOrder[i].time!.compareTo("21:00") == 0){
                          selectedTime = "";
                        }
                        else{
                          selectedTime = "21:00";
                        }
                      });
                    },
                    child: (listOrder[i].time!.compareTo("21:00") == 0)?Text('Không thể chọn'):Text('21:00'),
                  ),

              ],),

            SizedBox(
              height: 20,
            ),
            Text('Thời gian đã chọn: ${time} ${selectedTime}',style: TextStyle(fontSize: 16)),

            loginButton('Tạo yêu cầu'),
          ],
        ),
      ),
    );
  }
}