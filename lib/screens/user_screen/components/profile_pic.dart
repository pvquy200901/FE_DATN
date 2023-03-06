import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getInfoUserV2(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data!.avatar!.isEmpty ? "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png":"http://${AppConfig.IP}:50000/api/File/image/${snapshot.data!.avatar!}"),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 55,
                      width: 55,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Color(0xFFF5C75B),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child:
                            SvgPicture.asset("assets/images/camera-solid.svg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
