
 import 'package:dio/dio.dart';
 import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled/api/myAPI/chat_api.dart';
import 'package:untitled/api/myAPI/order_api.dart';
import 'package:untitled/api/myAPI/team_api.dart';
import 'package:untitled/model/weather_model/weather_model.dart';

 import '../config/app_config.dart';
import '../controller/app_controller.dart';
import 'myAPI/comment_api.dart';
import 'myAPI/login_api.dart';
import 'myAPI/news_api.dart';
import 'myAPI/recomment_api.dart';
import 'myAPI/register_api.dart';
import 'myAPI/stadium_api.dart';
import 'myAPI/user_api.dart';
import 'myAPI/weather_api.dart';

class BaseApi {
  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.BASE_URL,
    connectTimeout: 300000,
    receiveTimeout: 300000,
  ));
  Dio dioV2 = Dio(BaseOptions(
    baseUrl: AppConfig.BASE_URLV2,
    connectTimeout: 300000,
    receiveTimeout: 300000,
  ));


  void saveLog(e) async {
      if (e.response != null) {
        if (e.response.statusCode == 500 ||
            e.response.statusCode == 502 ||
            e.response.statusCode == 404) {
          appController.errorLog = 'Lỗi hệ thống vui lòng thử lại sau!';
        } else if (e.response.statusCode == 401 ||
            e.response.statusCode == 403 ||
            e.response.statusCode == 404) {
          appController.errorLog = 'Bạn không có quyền thực hiện thao tác!';
        } else if (e.response.statusCode == 400) {
          appController.errorLog = 'Vui lòng kiểm tra lại thông tin đăng nhập';
        }
      } else {
        bool hasInternet = await InternetConnectionChecker().hasConnection;
        if (hasInternet) {
          appController.errorLog = e.error.message;
        } else {
          appController.errorLog = 'Kiểm tra lại kết nối mạng';
        }
      }
    }
  }

class Api extends BaseApi
    with LogInApi,RegisterApi,UserApi,TeamApi,StadiumApi,OrderApi,NewsApi,CommentsApi, RecommentApi,ChatApi, WeatherApi{}

final Api api = Api();
