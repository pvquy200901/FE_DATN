
 import 'package:dio/dio.dart';

import '../../controller/app_controller.dart';
import '../api.dart';

mixin LogInApi on BaseApi {
  Future<bool> postUser(user, password) async {
    const url = '/api/User/login';
    try {
      Response response =
      await dio.post(url, data: {'username': user, 'password': password});
      if (response.statusCode == 200) {
        await appController.setLoginData(response.data);
        if (appController.token.isNotEmpty) {
         // appController.initRoute();
          return true;
        } else {
          appController.errorLog = 'Đăng nhập thất bại';
          return false;
        }
      } else {
        appController.errorLog = response.data['mess'];
        return false;
      }
    } catch (e) {
      print(e.toString());
      saveLog(e);
      return false;
    }
   return false;
  }
}
