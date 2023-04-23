
import '../../api/api.dart';
import '../../controller/app_controller.dart';
import 'package:dio/dio.dart';

import '../../model/comment_model/comment_model.dart';

mixin CommentsApi on BaseApi{

  Future<List<listComments>> getListCommentsInNews(news) async{
    const url = '/api/Comment/listCommentsInNews';
    try {
      Response response = await dio.get(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*','token':appController.token},
      ),
          queryParameters: {'news': news}
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => listComments.fromJson(e)).toList();
      } else {
        appController.errorLog = response.data['mess'];
        return [];
      }
    } catch (e) {
      saveLog(e);
      return [];
    }
  }




  Future<bool> createComments(news, comments) async {
    const url = '/api/Comment/createComments';
    try {
      Response response = await dio.post(url, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ),
          queryParameters: {'news': news, 'comment': comments}
      );
      print("ĐÃ ĐĂNG BÌNH LUẬN");
      return true;
    } catch (e) {
      saveLog(e);
      print("LỖI TÙM LUM HẾT + ${e}");
      return false;
    }
  }

  Future<bool> editComments(data) async {
    const url = '/api/Comment/editComments';
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

  Future<bool> deleteComments(data) async {
    const url = '/api/Comment/deleteComments';
    try {
      Response response = await dio.delete(url, data: data, options: Options(
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'token' : appController.token},
      ));

      return true;
    } catch (e) {
      saveLog(e);
      return false;
    }
  }


}