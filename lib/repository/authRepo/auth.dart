// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:nano/helper/api_manager.dart';
import 'package:nano/utils/constant.dart';

class AuthApi extends APIManager {
  final http.Client httpClient;

  AuthApi({
    required this.httpClient,
  });

  Future login(date) async {
    final url = Uri.parse(Constants.LOGIN);
    final response = await postAPICall(url, body: date);
    return response;
  }
}
