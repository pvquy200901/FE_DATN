import 'package:flutter/material.dart';
import 'item_user_confirm.dart';

class BodyConfirmUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            ItemMember(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );



  }
}
