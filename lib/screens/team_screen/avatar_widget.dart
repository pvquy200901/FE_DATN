import 'package:flutter/material.dart';

class AvatarUser extends StatelessWidget {
  AvatarUser({required this.image, required this.name});

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style:TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'RobotoMono',
          ),
        )
      ],
    );
  }
}
