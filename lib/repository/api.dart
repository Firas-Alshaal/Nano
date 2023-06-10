import 'package:nano/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> getHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await getToken()}',
      };

  Future getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(Constants.TOKEN);
  }
}
