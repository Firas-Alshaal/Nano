import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nano/repository/api.dart';
import 'package:nano/utils/constant.dart';

class APIManager extends Api {
  Future<dynamic> postAPICall(url, {Map? body}) async {
    final finalUrl = Uri.parse('${Constants.URL}$url');

    dynamic responseJson;
    try {
      final response = body == null
          ? await http.post(finalUrl, headers: await getHeaders())
          : await http.post(finalUrl,
              body: jsonEncode(body), headers: await getHeaders());
      responseJson = response; //_response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(url) async {
    final finalUrl = Uri.parse('${Constants.URL}$url');
    dynamic responseJson;
    try {
      final response = await http.get(finalUrl, headers: await getHeaders());
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}
