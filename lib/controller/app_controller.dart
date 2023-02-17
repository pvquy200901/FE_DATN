//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/session_storage_helper.dart';
import 'loading.dart';
import 'notification_controller.dart';

typedef void MenuCallback(ObjectKey);

class AppController extends GetxController {
  final PushNotificationStream pushNotificationStream =
  PushNotificationStream();
  final LoadingStream loadingStream = LoadingStream();
  RxBool isLoading = false.obs;
  RxBool isLogin = false.obs;
  String errorLog = '';
  String sucssesLog = '';
  String token = '';
  String user = '';
  String password = '';
  String role = '';
  String mainSlug = '';
  RxBool isSmall = false.obs;
  List<String> listCustomer = [];
  List<String> listCodeBuy = [];
  List<String> listName = [];
  List<String> listUser = [];
  List<String> listProductType = [];
  List<String> listPackageType = [];
  List<String> listProduct = [''];
  List<String> listPosition = [];
  List<Map<String, dynamic>> reportData = [];
  final RxBool showMessage = false.obs;


  void toastError(String title) {
    Get.snackbar(title, errorLog, backgroundColor: Colors.red);
  }

  void toastSucsses(String title) {
    Get.snackbar(title, sucssesLog,
        backgroundColor: Color.fromARGB(255, 20, 4, 247));
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future getLoginData() async {
    token = SessionStorageHelper.getValue('token');
    user = SessionStorageHelper.getValue('user');
    role = SessionStorageHelper.getValue('chucVu');
  }

  Future setLoginData(data) async {
    SessionStorageHelper.setValue('token', data['token']);
    SessionStorageHelper.setValue('user', data['user']);
    SessionStorageHelper.setValue('chucVu', data['chucVu'].toString());
    await getLoginData();
  }

  Future<bool> resetLoginData() async {
    SessionStorageHelper.clearAll();
    await getLoginData();
    return true;
  }

  loadingData([redirect = true]) async {

  }

  bool checkLogin () {
    return token.isNotEmpty;
  }

  void initRoute() {
  }
}

final AppController appController = Get.put(AppController());

