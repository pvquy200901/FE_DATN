
import 'package:untitled/model/recomment_model/recomment.dart';

import '../../api/api.dart';
import 'package:dio/dio.dart';

mixin RecommentApi on BaseApi{

  Future<recomment> postRecomment(outlook, temperature,level,reputation) async {
    const url = '/predict';
    try {
      Response response = await dioV2.post(url, data: {'outlook': outlook, 'temperature': temperature, 'level': level,'reputation':reputation});
      if (response.statusCode == 200){
        return recomment.fromJson(response.data);
      }
      else{
        return recomment();
      }
    } catch (e) {
      saveLog(e);
      print("LỖI TÙM LUM HẾT + ${e}");
      return recomment();
    }
  }
}