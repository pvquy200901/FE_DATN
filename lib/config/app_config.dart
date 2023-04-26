class AppConfig{
  static const IP = '10.0.241.89';
  static const APP_NAME  = 'Football Team';
  static const BASE_URL = 'http://${IP}:50000';
  static const BASE_URLV2 = 'http://${IP}:5000';

  static const DATE_FOMAT = 'dd/MM/yyyy HH:mm:ss';
  static const DATE_USER_FOMAT = 'dd/MM/yyyy';
  static const DATETIME_USER_FOMAT = 'dd/MM/yyyy HH:mm';
  static const ASSET_URL = BASE_URL+ '/Person/getImage?code=';
  static const TIME_DEFAULT_FOMAT = 'yyyy-MM-dd HH:mm:ss';
  static const EVENT_TIME_FOMAT = 'dd:MM:yyyy';
  static const FORMAT_DATE_API = 'dd-MM-yyyy';
  static const MAX_PRIORIRY = 99999;
}
