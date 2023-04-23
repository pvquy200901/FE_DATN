import 'dart:math';

import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/news_model/news_model.dart';

mixin NewsApi on BaseApi{
  Future<List<News>> getListNews() async{
    const url = '/api/News/list_News';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => News.fromJson(e)).toList();
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

  Future<infoNews> getInfoNewsForCustomer(code) async{
    const url = '/api/News/getInfoNewsForCustomer';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'news': code}
      );
      if (response.statusCode == 200) {
        return infoNews.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return infoNews();
      }
    } catch (e) {

      saveLog(e);
      return infoNews();
    }
  }

  //  Future<infoNews> getInfoNewsForCustomer(code) async{
  //   const url = '/api/News/getInfoNewsForCustomer';
  //   try {
  //     Response response = await dio.get(url, options: Options(
  //       headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
  //     ),
  //     queryParameters:{'code':code} );
  //     if (response.statusCode == 200) {

  //       print("------------------------------${response.data.toString()}");
  //       return infoNews.fromJson(response.data);

  //     } else {
  //       appController.errorLog = response.data['mess'];
  //        print("------------------------------ LỖI ${appController.errorLog}");
  //       return infoNews();
  //     }
  //   } catch (e) {

  //     saveLog(e);
  //     return infoNews();
  //   }
  // }

  Future<bool> createNews(title, des, shortDes,data) async {
    const url = '/api/News/createNews';
    try {
      Response response = await dio.post(url,data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),queryParameters: {'title':title,'des':des,'shortDes':shortDes });
      print("ĐÃ TẠO");
      return true;
    } catch (e) {
      saveLog(e);

      return false;
    }
  }

  Future<String> addImageNews(news,data) async {
    const url = '/api/News/addImageNews';
    try {
      Response response = await dio.put(url,data: data,options: Options(
        headers: {'Content-Type': 'multipart/form-data', 'accept': '*/*', 'token' : appController.token},
      ),
          queryParameters: {'team': news}
      );
      if(response.statusCode == 200){
        print("ĐÃ CẬP NHẬT ảnh");
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



}