import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/team_model/team_model.dart';

mixin TeamApi on BaseApi{
  Future<List<Team>> getListTeam() async{
    const url = '/api/User/listTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      ));
      if (response.statusCode == 200) {

        return (response.data as List).map((e) => Team.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {

      saveLog(e);
      return [];
    }
  }

  Future<bool> removeUserInTeam(team, name) async {
    const url = '/api/User/revomeUserInTeam';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
        queryParameters: {'team': team, 'name': name},
      );
      print("Đã xóa");
      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }

  Future<Team> getInfoTeam(team) async{
    const url = '/api/User/getInfoTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'team':team} );
      if (response.statusCode == 200) {
        return Team.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return Team();
      }
    } catch (e) {

      saveLog(e);
      print("==================== Lỗi" + e.toString());
      return Team();
    }
  }

  Future<Team> getInfoTeamOfUser(username) async{
    const url = '/api/User/getInfoTeamOfUser';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'username':username} );
      if (response.statusCode == 200) {
        return Team.fromJson(response.data);

      } else {
        appController.errorLog = response.data['mess'];
        return Team();
      }
    } catch (e) {

      saveLog(e);
      print("==================== Lỗi" + e.toString());
      return Team();
    }
  }

  Future<bool> createTeam(data) async {
    const url = '/api/User/createTeam';
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
  Future<bool> editTeam(data) async {
    const url = '/api/User/editTeam';
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
  Future<bool> joinTeam(team) async{
    const url = '/api/User/joinTeam';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'team':team} );
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

  Future<bool> outTeam(team) async{
    const url = '/api/User/outTeam';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'team':team} );
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
  Future<bool> reportTeam(team) async{
    const url = '/api/User/reportTeam';
    try {
      Response response = await dio.put(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters:{'team':team} );
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
  Future<String> setLogoTeam(team,data) async {
    const url = '/api/User/setLogoTeam';
    try {
      Response response = await dio.put(url,data: data,options: Options(
        headers: {'Content-Type': 'multipart/form-data', 'accept': '*/*', 'token' : appController.token},
      ),
          queryParameters: {'team': team}
      );
      if(response.statusCode == 200){
        print("ĐÃ CẬP NHẬT LOGO");
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

  Future<String> addImageTeam(team,data) async {
    const url = '/api/User/addImageTeam';
    try {
      Response response = await dio.put(url,data: data,options: Options(
        headers: {'Content-Type': 'multipart/form-data', 'accept': '*/*', 'token' : appController.token},
      ),
          queryParameters: {'team': team}
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