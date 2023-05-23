import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled/screens/stadium_screen/preview_image_widget.dart';
import 'package:untitled/screens/team_screen/avatar_widget.dart';

import '../../../api/api.dart';
import '../../../config/app_config.dart';
import '../../../model/team_model/team_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../../utils/constants.dart';
import '../user_screen.dart';
import 'package:dio/dio.dart' as dio;

class editTeam extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => editTeamState();
}
class editTeamState extends State<editTeam>{
  List<String> images =[];
  late dio.FormData m_data;
  final ImagePicker _picker = ImagePicker();
  Future<PickedFile?> pickedFile = Future.value(null);
  XFile? m_image;
  bool isLoading = true;
  infoUser user = infoUser();
  Team team = Team();
  loadData()async{
    setState(() {
      isLoading = true;
    });
    user = await api.getInfoUserV2();
    team = await api.getInfoTeamOfUser(user.username);
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

  final TextEditingController nameTxt = TextEditingController();
  final TextEditingController shortNameTxt = TextEditingController();
  final TextEditingController phoneTxt = TextEditingController();
  final TextEditingController desTxt = TextEditingController();
  final TextEditingController addressTxt = TextEditingController();
  final TextEditingController levelTxt = TextEditingController();

  String _selectedItem = "Giỏi";

  List<String> _dropdownItems = [
    'Giỏi',
    'Bình thường',
  ];
  Widget inputField(String hint, IconData iconData,
      TextEditingController _controller, String checked) {
    _controller.text = hint;
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
              //hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField2(String hint, IconData iconData,
      TextEditingController _controller, String checked) {
    _controller.text = hint;
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

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              //hintText: hint,
              labelText: 'Trình độ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(iconData),
              suffixIcon: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove bottom border
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                value: _selectedItem,
                onChanged: (newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          var data = {
            "name": nameTxt.text,
            "shortName": shortNameTxt.text,
            "phone": phoneTxt.text,
            "des": desTxt.text,
            "address": addressTxt.text,
            "level": _selectedItem,
          };
          api.editTeam(data).then((value) {
            if (value) {
              Fluttertoast.showToast(
                  msg: "Đã sửa đội bóng thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserPage();
              }));
            } else {
              Fluttertoast.showToast(
                  msg: "Không thể sửa đội bóng",
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return (isLoading) ?Center(child: CircularProgressIndicator()): SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cập nhật đội bóng", style: TextStyle(fontSize: 20, color: kBackgroundColor, fontFamily: 'Open Sans'),),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            team.logo!.isEmpty ? "https://dongphuchaianh.com/wp-content/uploads/2022/02/logo-ao-bong-da-lop-doi-vuong-mien.jpg":"http://${AppConfig.IP}:50000/api/File/image/${team.logo}"),
                      ),
                      Positioned(
                        right: -10,
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
                                api.setLogoTeam(team.name,data).then((value) =>{
                                  if(value.isNotEmpty){
                                    Fluttertoast.showToast(
                                        msg:
                                        "Đã cập nhật logo",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blueAccent,
                                        textColor: Colors.black,
                                        fontSize: 16.0),
                              Get.back()
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                        msg: "Cập nhật logo thất bại!",
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
              ),
              inputField(team.name!, Ionicons.person, nameTxt,""),
              inputField(team.shortName!, Ionicons.text, shortNameTxt,""),
              inputField(team.phone!, Ionicons.phone_landscape_outline, phoneTxt,""),
              inputField(team.des!, Ionicons.help_outline, desTxt,""),
              inputField(team.address!, Ionicons.location, addressTxt,""),
              inputField2("Trình độ", Ionicons.earth, levelTxt,""),
              loginButton('Cập nhật'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Ảnh",
                    // style: AppTextStyle.defaultHeaderOne,
                  ),
                  IconButton(onPressed: () async{
                    m_image = await _picker.pickImage(source: ImageSource.gallery);
                    if (m_image != null) {
                      final bytes = await m_image!.readAsBytes();
                      var dataImage = dio.MultipartFile.fromBytes(bytes,
                        filename: m_image!.name,
                      );
                      dio.FormData data =
                      dio.FormData.fromMap({'image': dataImage});
                      api.addImageTeam(team.name,data).then((value) =>{
                        if(value.isNotEmpty){
                          Fluttertoast.showToast(
                              msg:
                              "Đã cập nhật logo",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.black,
                              fontSize: 16.0),
                          Get.back()
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "Cập nhật logo thất bại!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0)
                        }
                      });
                    }
                  }, icon: Icon(Icons.image),color: Colors.black,),
                ],
              ),
              (team.imageTeam!.isEmpty)? Text("Chưa có hình ảnh nào"):SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(int i = 0 ; i < team.imageTeam!.length; i ++)
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: PreviewImage(image: "http://${AppConfig.IP}:50000/api/File/image/${team.imageTeam![i]}"),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}
