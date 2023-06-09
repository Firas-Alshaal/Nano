/*
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orgessor/repository/api.dart';
import 'package:orgessor/utils/constant.dart';

class APIManager extends Api {
  Future<dynamic> postAPICall(url, {Map? body}) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;
    try {
      final response = body == null
          ? await http.post(URL, headers: await getHeaders())
          : await http.post(URL,
              body: jsonEncode(body), headers: await getHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAddMediaAPICall(url, Map body, bool isProject) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());
      request.fields['orgoanization_id'] = body["orgoanization_id"];
      if (isProject) {
        request.files
            .add(await http.MultipartFile.fromPath('image', body["image"]));
        request.fields['name'] = body["name"];
        request.fields['description'] = body["description"];
        request.fields['start_date'] = body["start_date"];
        request.fields['end_date'] = body["end_date"];
      } else {
        String pdf = body["file"];
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'file', File(pdf).path,
            filename: pdf.split('/').last);
        request.files.add(multipartFile);
        request.fields['type'] = body["type"];
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postNewsAPICall(url, Map body) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());
      if (body["image"] == null) {
        request.fields['title'] = body["title"];
        request.fields['subtitle'] = body["subtitle"];
        request.fields['text'] = body["text"];
        request.fields['availability'] = body["availability"];
        request.fields['member_groups_ids'] = body["member_groups_ids"];
        request.fields['is_important'] = body["is_important"];
        request.fields['tags_ids'] = body["tags_ids"];
        request.fields['categories_ids'] = body["categories_ids"];
      } else {
        request.files
            .add(await http.MultipartFile.fromPath('image', body["image"]));
        request.fields['title'] = body["title"];
        request.fields['subtitle'] = body["subtitle"];
        request.fields['text'] = body["text"];
        request.fields['availability'] = body["availability"];
        request.fields['member_groups_ids'] = body["member_groups_ids"];
        request.fields['is_important'] = body["is_important"];
        request.fields['tags_ids'] = body["tags_ids"];
        request.fields['categories_ids'] = body["categories_ids"];
      }
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postOrganizationAPICall(
      url, Map body, bool isAddedMedia) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      List<http.MultipartFile> pdfsList = [];
      List<http.MultipartFile> mediasList = [];
      List<http.MultipartFile> sponsorsList = [];
      List<http.MultipartFile> orgProjectImagesList = [];

      for (var media in body['medias[]']) {
        var multipartFile = await http.MultipartFile.fromPath(
            'medias[]', File(media).path,
            filename: media.split('/').last);
        mediasList.add(multipartFile);
      }
      for (File pdf in body['PDFs[]']) {
        var multipartFile = await http.MultipartFile.fromPath(
            'PDFs[]', pdf.path,
            filename: pdf.path.split('/').last);
        pdfsList.add(multipartFile);
      }
      for (var sponsor in body['sponsers[]']) {
        var multipartFile = await http.MultipartFile.fromPath(
            'sponsers[]', File(sponsor).path,
            filename: sponsor.split('/').last);
        sponsorsList.add(multipartFile);
      }
      for (var orgProjectImage in body['org_projects_image[]']) {
        var multipartFile = await http.MultipartFile.fromPath(
            'org_projects_image[]', File(orgProjectImage).path,
            filename: orgProjectImage.split('/').last);
        orgProjectImagesList.add(multipartFile);
      }

      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());
      request.files.addAll(pdfsList);
      request.files.addAll(mediasList);
      request.files.addAll(sponsorsList);
      request.files.addAll(orgProjectImagesList);

      if (!isAddedMedia) {
        request.files
            .add(await http.MultipartFile.fromPath('logo', body["logo"]));
        request.files
            .add(await http.MultipartFile.fromPath('cover', body["cover"]));
        request.fields['name'] = body["name"];
        request.fields['about_us'] = body["about_us"];
        request.fields['phone'] = body["phone"];
        request.fields['domin'] = body["domin"];
        request.fields['org_infos'] = body["org_infos"].toString();
        request.fields['questions'] = body["questions"].toString();
        request.fields['availability'] = body["availability"];
        request.fields['tags_ids'] = body["tags_ids"];
        request.fields['categories_ids'] = body["categories_ids"];
        request.fields['user_ids'] = body["user_ids"];
        request.fields['create_date'] = body["create_date"];
      }
      request.fields['type'] = body["type"];
      request.fields['org_project'] = body["org_project"].toString();
      request.fields['company_name'] = body["company_name"];

      if (isAddedMedia) {
        request.fields['group_id'] = body["group_id"];
        request.fields['id'] = body["id"];
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> editOrganizationAPICall(url, Map body) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());

      body["logo"].toString().contains('https')
          ? request.fields['logo'] = body["logo"]
          : request.files
              .add(await http.MultipartFile.fromPath('logo', body["logo"]));
      body["cover"].toString().contains('https')
          ? request.fields['cover'] = body["cover"]
          : request.files
              .add(await http.MultipartFile.fromPath('cover', body["cover"]));
      request.fields['group_id'] = body["group_id"];
      request.fields['id'] = body["id"];
      request.fields['about_us'] = body["about_us"];
      request.fields['phone'] = body["phone"];
      request.fields['domin'] = body["domin"];
      request.fields['availability'] = body["availability"];
      request.fields['create_date'] = body["create_date"];
      request.fields['type'] = body["type"];
      request.fields['company_name'] = body["company_name"];
      request.fields['org_project'] = body["org_project"].toString();

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postLocationAPICall(url, Map body) async {
    var responseJson;
    try {
      final response = await http.post(url,
          body: jsonEncode(body), headers: await getHeaders2());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postCreateEventAPICall(url, Map body) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());
      if (body["image"] == null) {
        request.fields['title'] = body["title"];
        request.fields['description'] = body["description"];
        request.fields['tags_ids'] = body["tags_ids"];
        request.fields['publish_status'] = body["publish_status"];
        request.fields['start_date'] = body["start_date"];
        request.fields['time'] = body["time"];
        request.fields['goal'] = body["goal"];
        request.fields['limit_of_attenders'] = body["limit_of_attenders"];
        request.fields['type'] = body["type"];
        request.fields['end_date'] = body["end_date"];
        request.fields['categories_ids'] = body["categories_ids"];
        request.fields['availability'] = body["availability"];
        request.fields['member_groups_ids'] = body["member_groups_ids"];
        request.fields['latitude'] = body["latitude"];
        request.fields['longitude'] = body["longitude"];
        request.fields['city'] = body["city"];
        request.fields['street'] = body["street"];
        request.fields['country'] = body["country"];
        request.fields['publish_date'] = body["publish_date"];
        request.fields['invitation_user_id'] = body["invitation_user_id"];
      } else {
        request.files
            .add(await http.MultipartFile.fromPath('image', body["image"]));
        request.fields['title'] = body["title"];
        request.fields['description'] = body["description"];
        request.fields['tags_ids'] = body["tags_ids"];
        request.fields['publish_status'] = body["publish_status"];
        request.fields['start_date'] = body["start_date"];
        request.fields['time'] = body["time"];
        request.fields['goal'] = body["goal"];
        request.fields['limit_of_attenders'] = body["limit_of_attenders"];
        request.fields['type'] = body["type"];
        request.fields['end_date'] = body["end_date"];
        request.fields['categories_ids'] = body["categories_ids"];
        request.fields['availability'] = body["availability"];
        request.fields['member_groups_ids'] = body["member_groups_ids"];
        request.fields['latitude'] = body["latitude"];
        request.fields['longitude'] = body["longitude"];
        request.fields['city'] = body["city"];
        request.fields['street'] = body["street"];
        request.fields['country'] = body["country"];
        request.fields['publish_date'] = body["publish_date"];
        request.fields['invitation_user_id'] = body["invitation_user_id"];
      }
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> editImageProfileAPICall(url, Map body) async {
    final URL = Uri.parse('${Constants.URL}$url');

    var responseJson;

    try {
      var request = http.MultipartRequest('POST', URL);
      request.headers.addAll(await getHeaders());
      request.files.add(await http.MultipartFile.fromPath(
          body.keys.first, body[body.keys.first]));
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(url) async {
    final URL = Uri.parse('${Constants.URL}$url');
    var responseJson;
    try {
      final response = await http.get(URL, headers: await getHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteAPICall(url) async {
    final URL = Uri.parse('${Constants.URL}$url');
    var responseJson;
    try {
      final response = await http.delete(URL, headers: await getHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
      case 422:
      case 404:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 401:
      case 403:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 500:
        var responseJson = json.decode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error Occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
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

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
*/
