import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/user_screen/manager_account/manager_account_input.dart';

import 'dart:math' as math;
import '../../../api/api.dart';
import '../../../model/order_model/list_model.dart';
import '../components/profile_pic.dart';

class BodyHistory extends StatefulWidget {
  const BodyHistory({Key? key}) : super(key: key);

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}
class _BodyHistoryState extends State<BodyHistory> {

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.1 * screenWidth,
        height: 1.1 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xB316BFC4),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color(0xDB4BE8CC),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }

  List<myOrder> orders = [];
  bool isLoading = false;

  loadData() async{
    setState(() {
      isLoading = true;
    });

    orders = await api.getListInfoOrderForUser();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Padding(
          padding: const EdgeInsets.only(
              top: 28.0, left: 18.0, right: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lịch sử đặt sân theo đội",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(columns: [

                    DataColumn(
                        label: Text('Ngày đặt',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Thời gian bắt đầu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Thời gian kết thúc',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tổng tiền',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tên sân',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Địa chỉ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Trạng thái',
                            style: TextStyle(
                                fontWeight: FontWeight.bold))),
                  ], rows: orders.map((e){
                    final DataRow dataRow = DataRow(
                      cells: [
                        DataCell(Text(e.date!)),
                        DataCell(Text(e.startTime!)),
                        DataCell(Text(e.endTime!)),
                        DataCell(Text(e.price!)),
                        DataCell(Text(e.nameStadium!)),
                        DataCell(Text(e.address!)),
                        DataCell(Text(e.state!)),
                      ],
                    );
                    return dataRow;
                  }).toList()),
                ),
              )

            ],
          ),
        ),
      ),
    );



  }
}
