

import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/stadium_model/stadium_model.dart';
import '../../model/team_model/team_model.dart';


mixin StadiumApi on BaseApi{
  Future<List<Stadium>> getListStadiumForCustomer() async{
    const url = '/api/User/listStadium';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ));
      if (response.statusCode == 200) {

        return (response.data as List).map((e) => Stadium.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<Stadium> getInfoStadium(name) async{
    const url = '/api/User/getInfoStadium';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'name': name}
      );
      if (response.statusCode == 200) {
        return Stadium.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return Stadium();
      }
    } catch (e) {

      saveLog(e);
      return Stadium();
    }
  }

}