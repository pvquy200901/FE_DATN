import 'dart:math';


import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/order_model/list_model.dart';

mixin OrderApi on BaseApi{
  Future<List<listOrder>> getListOrderForCustomer() async{
    const url = '/api/User/listHistory';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => listOrder.fromJson(e)).toList();

      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<List<listOrder>> getListOrderForCustomerV2() async{
    const url = '/api/User/listOrder';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => listOrder.fromJson(e)).toList();

      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<infoOrder> getInfoOrderForCustomer(code) async{
    const url = '/api/Order/getInfoOrder';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'code':code} );
      if (response.statusCode == 200) {
        return infoOrder.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return infoOrder();
      }
    } catch (e) {

      saveLog(e);
      return infoOrder();
    }
  }

  Future<List<myOrder>> getListInfoOrderForUser() async{
    const url = '/api/Order/getListInfoOrderForUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => myOrder.fromJson(e)).toList();

      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      print(e.toString());

      saveLog(e);
      return [];
    }
  }

  Future<bool> cancelOrder(code) async {
    const url = '/api/Order/cancelOrderOfCustomer';
    try {
      Response response = await dio.delete(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'order':code} );
      if (response.statusCode == 200) {
        return true;

      } else {
        appController.errorLog = response.data['mess'];
        return false;
      }
    } catch (e) {
      saveLog(e);
      return false;
    }
  }


  Future<bool> createOrder(data) async {
    const url = '/api/Order/createOrder';
    try {
      Response response = await dio.post(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<List<listOrder>> getListOrderAllTime(date) async{
    const url = '/api/Order/listAllOrder';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'time': date}
      );
      if (response.statusCode == 200) {
        //print(response.data.toString());
        return (response.data as List).map((e) => listOrder.fromJson(e)).toList();

      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<List<itemOrder>> getListOrderUser(date, name) async{
    const url = '/api/Order/listAllOrderUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'time': date, 'stadium': name}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => itemOrder.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<List<String>> getListStadiumTime(date) async{
    const url = '/api/Order/listAllStadiumTime';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'time': date}
      );
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>).cast<String>();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<List<myOrder>> getListOrderWithTeam(String team) async{
    const url = '/api/User/getListOrderWithTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},

      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => myOrder.fromJson(e)).toList();

      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      print(e.toString());

      saveLog(e);
      return [];
    }
  }

}
