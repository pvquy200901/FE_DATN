import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';
import 'package:dio/dio.dart' as dio;

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late dio.FormData m_data;
    final ImagePicker _picker = ImagePicker();
    Future<PickedFile?> pickedFile = Future.value(null);
    XFile? m_image;
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
                        onPressed: () async{
                          m_image = await _picker.pickImage(source: ImageSource.gallery);
                          if (m_image != null) {
                            final bytes = await m_image!.readAsBytes();
                            var dataImage = dio.MultipartFile.fromBytes(bytes,
                              filename: m_image!.name,
                            );
                            dio.FormData data =
                            dio.FormData.fromMap({'image': dataImage});
                            api.setAvatarUser(data).then((value) =>{
                              if(value.isNotEmpty){
                                Fluttertoast.showToast(
                                    msg:
                                    "Đã cập nhật ảnh đại diện",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.blueAccent,
                                    textColor: Colors.black,
                                    fontSize: 16.0),

                              }
                              else{
                                Fluttertoast.showToast(
                                    msg: "Cập nhật ảnh đại diện thất bại!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0)
                              }
                            });
                          }
                        },
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
