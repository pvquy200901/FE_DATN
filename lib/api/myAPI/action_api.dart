import 'dart:math';

import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/action_model/action.dart';

mixin ActionApi on BaseApi{
  Future<List<mAction>> getListAction(type) async{
    const url = '/api/Action/getListActionType';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ), queryParameters: {'type': type});
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => mAction.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      print("Loi ${e.toString()}");
      saveLog(e);
      return [];
    }
  }

  Future<List<mAction>> getListActionForUser() async{
    const url = '/api/Action/getListActionForUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => mAction.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      print("Loi ${e.toString()}");
      saveLog(e);
      return [];
    }
  }


  Future<List<mAction>> getListConfirmActionForUser() async{
    const url = '/api/Action/getListConfirmActionForUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => mAction.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      print("Loi ${e.toString()}");
      saveLog(e);
      return [];
    }
  }

  Future<bool> createAction(des, time, type) async {
    const url = '/api/Action/createAction';
    try {
      Response response = await dio.post(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),queryParameters: {'des':des,'time':time,'type':type });
      print("ĐÃ TẠO");
      return true;
    } catch (e) {
      saveLog(e);

      return false;
    }
  }
  Future<bool> confirmAction(code) async {
    const url = '/api/Action/setConfirmedAction';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
        queryParameters: {'code': code},
      );

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<bool> deleteAction(code) async {
    const url = '/api/Action/deleteAction';
    try {
      Response response = await dio.delete(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
        queryParameters: {'code': code},
      );

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }



}