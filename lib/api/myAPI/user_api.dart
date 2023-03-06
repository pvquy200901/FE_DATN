
import 'package:dio/dio.dart';

import '../../controller/app_controller.dart';
import '../../model/user_model/user_model.dart';
import '../api.dart';
mixin UserApi on BaseApi {
  Future<bool> updateUser(data) async {
    const url = '/api/User/editUser';
    try {
      Response response = await dio.put(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<UserModel> getInfoUser() async{
    const url = '/api/User/getInfoUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        print("------------------------------${response.data.toString()}");
        return UserModel.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return UserModel();
      }
    } catch (e) {

      saveLog(e);
      return UserModel();
    }
  }

  Future<List<UserModel>> getListUserInTeam(team) async{
    const url = '/api/User/getListUserInTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {

        return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<List<UserModel>> getListUserComing(team) async{
    const url = '/api/User/getListUserComing';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {

        return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      } else {

        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<bool> acceptUser(username) async {
    const url = '/api/User/acpUser';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
        queryParameters: {'username': username},
      );

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<bool> cancelUser(username) async {
    const url = '/api/User/cancelUser';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
        queryParameters: {'username': username},
      );

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<String> setAvatarUser(data) async {
    const url = '/api/User/setAvatarUser';
    try {
      Response response = await dio.put(url,data: data,options: Options(
        headers: {'Content-Type': 'multipart/form-data', 'accept': '*/*', 'token' : appController.token},
      ),

      );
      if(response.statusCode == 200){
        print("ĐÃ CẬP NHẬT AVATAR");
        return response.data;
      }
      else{
        return "";
      }
    } catch (e) {
      saveLog(e);
      print(e);
      return "";
    }
  }

  Future<infoUser> getInfoUserV2() async{
    const url = '/api/User/getInfoUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        //print("------------------------------${response.data.toString()}");
        return infoUser.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return infoUser();
      }
    } catch (e) {

      saveLog(e);
      return infoUser();
    }
  }

}