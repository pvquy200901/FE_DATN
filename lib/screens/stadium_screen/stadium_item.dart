import 'dart:ffi';

import 'package:flutter/material.dart';

import 'info_stadium.dart';

class IteamStadium extends StatelessWidget {
  // const PopularWidget({
  //   Key? key,
  // }) : super(key: key);

  IteamStadium({
    required this.address,
    required this.desc,
    required this.name,
    required this.money,
    required this.image,
  });

  final String address;
  final String desc;
  final String name;
  final int money;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // height: 120.h,
        width: 325,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
          child: Row(children: [
            Container(
              width: 115,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 8, 31, 42),
                            fontFamily: 'RobotoMono')),

                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 28, 159, 226),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 8, 31, 42),
                                  fontFamily: 'RobotoMono')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),

                    Text(
                        overflow: TextOverflow.ellipsis,
                        desc,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 8, 31, 42),
                            fontFamily: 'RobotoMono')),

                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(money.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 248, 19, 19),
                                fontFamily: 'RobotoMono')),
                        SizedBox(
                          width: 4,
                        ),
                        Text("/1h",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 248, 19, 19),
                                fontFamily: 'RobotoMono'))
                      ],
                    ),
                  ],
                ))
          ]),

        ),

      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new InfoStadium(name: name,);
        }));
      },
    );
  }
}
