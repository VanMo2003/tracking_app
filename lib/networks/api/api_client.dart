import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:traking_app/models/response/error_res.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:http/http.dart' as Http;
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:traking_app/utils/language/key_language.dart';

import '../../models/body/multipart.dart';

class ApiClient extends GetxService {
  final String urlBase;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage =
      KeyLanguage.connectionToApiServerFailed.tr;
  final int timeoutInSeconds = 90;

  String token = "";
  Map<String, String> _mainHeaders = {};

  ApiClient({required this.urlBase, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstant.TOKEN) ??
        "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    if (Foundation.kDebugMode) {
      debugPrint('Token: $token');
    }

    updateHeader(
      token,
      null,
      sharedPreferences.getString(AppConstant.LANGUAGE_CODE),
      0,
    );
  }

  void updateHeader(
    String token,
    List<int>? zoneIDs,
    String? languageCode,
    int moduleID,
  ) {
    Map<String, String> _header = {
      'content-type': 'application/json; charset=utf-8',
      AppConstant.LOCALIZATION_KEY: languageCode ?? "vi",
      "Authorization": token,
    };

    _header.addAll({AppConstant.MODULE_ID: moduleID.toString()});
    _mainHeaders = _header;
  }

  Future<Response> getData(String uri,
      {Map<String, String>? query, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> Api Call : $uri\nHeader: $_mainHeaders');
      }
      Http.Response response = await Http.get(
        Uri.parse(urlBase + uri).replace(queryParameters: query),
        headers: header ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('Error : ${e.toString()}');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? header}) async {
    try {
      String requestBody = jsonEncode(body);
      if (Foundation.kDebugMode) {
        debugPrint('====> API Call : $uri\nHeader : ${header ?? _mainHeaders}');
        debugPrint('====> API Body : $requestBody');
      }
      Http.Response response = await Http.post(
        Uri.parse(urlBase + uri),
        body: requestBody,
        headers: header ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('===> Error : ${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, MultipartBody multipartBody,
      {required Map<String, String>? headers, String? filename}) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint(
            '====> API Body: {${multipartBody.key} : ${multipartBody.file}}');
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(urlBase + uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      if (multipartBody.file != null) {
        Uint8List _list = await multipartBody.file!.readAsBytes();
        _request.files.add(Http.MultipartFile(
          multipartBody.key,
          multipartBody.file!.readAsBytes().asStream(),
          _list.length,
          filename: filename,
        ));
      }
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postDataLogin(
      String uri, dynamic body, Map<String, String>? header) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: ${header ?? _mainHeaders}');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(urlBase + uri),
        body: body,
        headers: header ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: ${header ?? _mainHeaders}');
        print('====> API Body: $body');
      }

      Http.Response _response = await Http.put(
        Uri.parse("$urlBase$uri"),
        body: jsonEncode(body),
        headers: header ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {int? id, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        print(
            '====> API Call: $uri/${id ?? ""}\nHeader: ${header ?? _mainHeaders}');
      }

      Http.Response _response = await Http.delete(
        Uri.parse(id != null ? "$urlBase$uri/$id" : "$urlBase$uri"),
        headers: header ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      if (response.body != "") {
        _body = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      }
    } catch (e) {
      // _body = jsonDecode(response.body);
      debugPrint('Error : ${e.toString()}');
    }
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(_response.body);
      _response = Response(
        statusCode: _response.statusCode,
        body: _response.body,
        statusText: errorResponse.errors![0].message,
      );
    } else if (_response.body.toString().startsWith("{message")) {
      _response = Response(
        statusCode: _response.statusCode,
        body: _response.body,
        statusText: _response.body['message'],
      );
    }
    if (Foundation.kDebugMode) {
      debugPrint('====> Api Response : [${_response.statusCode}] $uri\n');
    }
    return _response;
  }
}
