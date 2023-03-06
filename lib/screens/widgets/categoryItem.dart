import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../stadium_screen/info_stadium.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String name;
  final String address;
  final String type;
  final String money;

  CategoryItem({
    required this.image,
    required this.name,
    required this.address,
    required this.type,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 275,
          height: 200,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new InfoStadium(name: name,);
                }));
              },
              splashColor: Color.fromARGB(255, 245, 242, 242),
            ),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 50,
          width: 222,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13),
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 1, left: 1, top: 1, bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        name,
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(229, 81, 175, 41),
                            fontFamily: 'RobotoMono')),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 28, 159, 226),
                            size: 20,
                          ),
                           Text(address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(229, 81, 175, 41),
                                    fontFamily: 'RobotoMono')),

                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
        // child: Text("Halo"),
      ],
    );
  }
}
