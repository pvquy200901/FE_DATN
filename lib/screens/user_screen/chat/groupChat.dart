import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/model/user_model/user_model.dart';
import 'package:untitled/screens/user_screen/chat/showMessages.dart';

import '../../../api/api.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({Key? key}) : super(key: key);

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  var _focusNode = FocusNode();

  XFile? imagefile;

  void _reloadWidget() {
    setState(() {
    });
  }
  focusListener() {
    setState(() {});
  }
  infoUser info = infoUser();
  bool isLoading = false;
  loadData() async {
    setState(() {
      isLoading = true;
    });
    info = await api.getInfoUserV2();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _focusNode.addListener(focusListener);
    loadData();
    super.initState();

  }

  @override
  void dispose() {
    _focusNode.removeListener(focusListener);
    super.dispose();
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              "Upload Image",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    imageSelect(ImageSource.gallery);
                  },
                  leading: Icon(
                    Icons.photo_album,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Gallery",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Camera",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void imageSelect(ImageSource source) async {
    XFile? pickedimage = await ImagePicker().pickImage(source: source);
    if (pickedimage != null) {
      cropImage(pickedimage);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? cropedImage = (await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 20,
    ));

    if (cropedImage != null) {
      setState(() {
        imagefile = XFile(cropedImage.path);
      });
     /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewImage(
                picture: imagefile,
                chatroom: widget.chatroom,
                currentuser: widget.currentuser,
                targetuser: widget.targetuser,
              )));*/
    }
  }

  TextEditingController msgcontroller = TextEditingController();

  void sendmessage() async {
    String message = msgcontroller.text.trim();
    msgcontroller.clear();
    if (message != "") {
      api.createChat(info.team, message).then((value) => _reloadWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          /*shadowColor: Colors.transparent,
          toolbarHeight: 100,
          elevation: 5,
          scrolledUnderElevation: 5,
          automaticallyImplyLeading: true,*/
          backgroundColor: Color(0xffFFFFFF),
          leading: BackButton(color: Colors.black),
          title: SizedBox(
           /* width: 290,
            height: 59,*/
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     "Nhóm chat đội ${info.team}",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff222222),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: ShowMessages(
                    m_team: info.team!,
                    m_user: info.name!,
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 20),
                      width: MediaQuery.of(context).size.width - 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffF3F3F3),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDBDBDB),
                            blurRadius: 15,
                            spreadRadius: 1.5,
                          ),
                        ],
                      ),

                      child: TextFormField(
                        //textInputAction: TextInputAction.continueAction,
                        controller: msgcontroller,
                        decoration: InputDecoration(
                          hintText: 'Soạn tin nhắn',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 19,
                            left: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        right: 0,
                        left: 10,
                      ),
                      child: FloatingActionButton(
                        elevation: 15,
                        onPressed: () {},
                        child: ElevatedButton(
                          onPressed: () {
                            sendmessage();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xffFFFFFF),
                            backgroundColor: Color(0xff2865DC),
                            shape: CircleBorder(),
                            disabledForegroundColor:
                            Color(0xff2865DC).withOpacity(0.38),
                            disabledBackgroundColor:
                            Color(0xff2865DC).withOpacity(0.12),
                            padding: EdgeInsets.all(10),
                          ),
                          child: Icon(Icons.send)
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}