

import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';
import '../../model/chat_model/chatModel.dart';

mixin ChatApi on BaseApi{

  Future<List<Chat>> getListChatInTeam(team) async{
    const url = '/api/GroupChat/listChatInTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Chat.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }


  Future<List<Chat>> getListMyChat(team) async{
    const url = '/api/GroupChat/listMyChat';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Chat.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }

  Future<List<Chat>> getListAllChat(team) async{
    const url = '/api/GroupChat/listAllChatInTeam';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'team': team}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Chat.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }

  Future<bool> createChat(team, chat) async {
    const url = '/api/GroupChat/createInbox';
    try {
      Response response = await dio.post(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
          queryParameters: {'team': team, 'chat': chat}
      );
      return true;
    } catch (e) {
      saveLog(e);
      print("LỖI TÙM LUM HẾT + ${e}");
      return false;
    }
  }



//  Future<bool> deleteComments(data) async {
//   const url = '/api/Comment/deleteComments';
//   try {
//     Response response = await dio.delete(url, data: data, options: Options(
//       headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
//     ));

//     return true;
//   } catch (e) {
//     saveLog(e);
//     return false;
//   }
// }


}