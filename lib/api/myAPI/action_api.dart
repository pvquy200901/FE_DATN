import 'dart:math';

import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/action_model/action.dart';

mixin ActionApi on BaseApi{
  Future<List<Action>> getListAction(type) async{
    const url = '/api/Action/getListActionType';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ), queryParameters: {'type': type});
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Action.fromJson(e)).toList();
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

  // Future<List<News>> getListNewsForUser() async{
  //   const url = '/api/User/listNews';
  //   try {
  //     Response response = await dio.get(url, options: Options(
  //       headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
  //     ));
  //     if (response.statusCode == 200) {
  //       return (response.data as List).map((e) => News.fromJson(e)).toList();
  //     } else {
  //       appController.errorLog = response.data['mess'];
  //       return [];
  //     }
  //   } catch (e) {
  //     print("Loi ${e.toString()}");
  //     saveLog(e);
  //     return [];
  //   }
  // }

  // Future<Action> getInfoNewsForCustomer(code) async{
  //   const url = '/api/News/getInfoNewsForCustomer';
  //   try {
  //     Response response = await dio.get(url, options: Options(
  //       headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
  //     ),
  //         queryParameters: {'news': code}
  //     );
  //     if (response.statusCode == 200) {
  //       return Action.fromJson(response.data);
  //
  //     } else {
  //       appController.errorLog = response.data['mess'];
  //       return Action();
  //     }
  //   } catch (e) {
  //
  //     saveLog(e);
  //     return Action();
  //   }
  // }
  //
  // //  Future<infoNews> getInfoNewsForCustomer(code) async{
  // //   const url = '/api/News/getInfoNewsForCustomer';
  // //   try {
  // //     Response response = await dio.get(url, options: Options(
  // //       headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
  // //     ),
  // //     queryParameters:{'code':code} );
  // //     if (response.statusCode == 200) {
  //
  // //       print("------------------------------${response.data.toString()}");
  // //       return infoNews.fromJson(response.data);
  //
  // //     } else {
  // //       appController.errorLog = response.data['mess'];
  // //        print("------------------------------ LỖI ${appController.errorLog}");
  // //       return infoNews();
  // //     }
  // //   } catch (e) {
  //
  // //     saveLog(e);
  // //     return infoNews();
  // //   }
  // // }
  //
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
  //
  // Future<String> addImageNews(news,data) async {
  //   const url = '/api/News/addImageNews';
  //   try {
  //     Response response = await dio.put(url,data: data,options: Options(
  //       headers: {'Content-Type': 'multipart/form-data', 'accept': '*/*', 'token' : appController.token},
  //     ),
  //         queryParameters: {'team': news}
  //     );
  //     if(response.statusCode == 200){
  //       print("ĐÃ CẬP NHẬT ảnh");
  //       return response.data;
  //     }
  //     else{
  //       return "";
  //     }
  //   } catch (e) {
  //     saveLog(e);
  //     print(e);
  //     return "";
  //   }
  // }



}