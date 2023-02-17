
 import 'package:dio/dio.dart';

import '../../controller/app_controller.dart';
import '../api.dart';

mixin RegisterApi on BaseApi {
 Future<bool> registerUser(name, user, password, email) async {
    const url = '/api/User/registerUser';
    try {
      Response response = await dio.post(url, data: {
        'name': name,
        'username': user,
        'password': password,
        'email': email
      });
      if (response.statusCode == 200) {
        appController.sucssesLog = 'Đăng kí thành công';
        return true;
      } else {
        appController.errorLog = "Đăng kí thất bại test";
        return false;
      }
    } catch (e) {
      saveLog(e);
      return false;
    }
   }

}
