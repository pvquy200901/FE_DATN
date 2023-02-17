import 'package:universal_html/html.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SessionStorageHelper{
  static late SharedPreferences sessionStorage;

  static init() async {
    sessionStorage = await SharedPreferences.getInstance();
  }
  static setValue(String name, String value){
    sessionStorage.setString(name, value);
    return value;
  }

  static String getValue(String name){
    return sessionStorage.getString(name)??'';
  }

  static void removeValue(String name){
    sessionStorage.remove(name);
  }

  static void clearAll(){
    sessionStorage.clear();
  }
}