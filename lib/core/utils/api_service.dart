//import 'package:dio/dio.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio;

// BaseOptions options = BaseOptions(
// baseUrl: 'http://127.0.0.1:8000/api/de',
//// connectTimeout: 5000,
// //receiveTimeout: 3000,
// );

// final _baseUrl = 'https://192.168.2.104:8000/api/';
  ApiService(this._dio);
  Future<dynamic> get({
    required String url,
    @required String? token,
    @required dynamic body,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "ngrok-skip-browser-warning": "69420"
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    final Response response = await _dio.get(url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> delete(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
//i deleted Bearer before the token
    }

    final Response response = await _dio.delete(
      data: body,
      url,
      options: Options(
        headers: headers,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      response.data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "ngrok-skip-browser-warning": "69420"
    };

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    Response response = await _dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = response.data;
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${response.data}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll(
        {'Content-Type': 'application/json', 'Accept': 'application/json'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    Response response = await _dio.put(
      url,
      data: body,
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${response.data}');
    }
  }

  Future<dynamic> download(
      {required String url,
      required String downloadPath,
      required CancelToken? cancelToken,
      required void Function(int count, int total)? onReceiveProgress,
//
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll(
        {'Content-Type': 'application/json', 'Accept': 'application/json'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
//var dir = await getApplicationDocumentsDirectory();
    var dir = Directory(downloadPath);
    if (await dir.exists()) {
      return true;
    }
    Response response = await _dio.download(
      url,
      downloadPath,
      cancelToken: cancelToken,

//data: body,
      options: Options(headers: headers),
      onReceiveProgress: onReceiveProgress,
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${response.data}');
    }
  }

  Future<dynamic> upload({
    required String url,
    // required File file,
    required Map<String, dynamic> body,
    required String? token,
    required CancelToken? cancelToken,
    required void Function(int count, int total)? onSendProgress,
  }) async {
    Map<String, String> headers = {'Accept': 'application/json'};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    var formData = FormData.fromMap(body
        //       {
        //   'video': await MultipartFile.fromFile(file.path),
        // }
        );

    Response response = await _dio.post(
      url,
      options: Options(headers: headers),
      data: formData,
      onSendProgress: onSendProgress,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = response.data;
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${response.data}');
    }
  }

// Future<dynamic> uploadImage({
//     required String uri,
//     required String? token,

// required PlatformFile file,
//     required Map<String, dynamic> body,

// }) async {

//     Map<String, String> headers = {'Accept': 'application/json'};

//     if (token != null) {
//       headers.addAll({'Authorization': 'Bearer $token'});
//     }

//   // Define the body
//   // Map<String, dynamic> body = {
//   //   'image': base64Encode(file.bytes),
//   //   'filename': file.name,
//   //   // Add other fields if required
//   // };

//   var url = Uri.parse(uri);

//   var request = http.MultipartRequest('POST', url,)
//   ..headers.addAll(headers)
//   ..fields['data']=jsonEncode(body);

//   var multipartFile = http.MultipartFile(
//     'image', // consider 'image' as the field name specified by your API
//     http.ByteStream.fromBytes(file.bytes!.toList()), // use file.bytes instead of file.path
//     file.size,
//     filename: file.name,

//     contentType: MediaType('image', 'jpeg'),
//   );

//   request.files.add(multipartFile);

//   var response = await request.send();

//   if (response.statusCode == 200) {
//   // Convert the Stream<List<int>> to a String
//   String responseString = await response.stream.bytesToString();

//   // Decode the JSON response
//   Map<String, dynamic> data = jsonDecode(responseString);
//       return data;
//   } else {
//       throw Exception(
//           'there is a problem with status code ${response.statusCode} with body ${response.stream.bytesToString()}');
//     }
// }
}
