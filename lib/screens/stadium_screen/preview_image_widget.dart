import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  PreviewImage({required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
