import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.service.dart';
import 'package:redditech/services/local/local.service.dart';

const tokenUrl = 'https://www.reddit.com/api/v1/access_token';

extension Login on ApiService {
  static final _localService = locator<LocalService>();
  static final _dio = Dio();

  String? getCode(String? redirectUrl) {
    code = Uri.parse(redirectUrl!).queryParameters['code'];
    log("code: $code");
    return code;
  }

  Future<Token?> getFirstToken() async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    Token? token = Token.empty();

    try {
      var auth =
          'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));

      final res = await _dio.post(
        'https://www.reddit.com/api/v1/access_token',
        data: FormData.fromMap(
          {
            'grant_type': 'authorization_code',
            'code': code, // this is your code part
            'redirect_uri': redirectUrl,
          },
        ),
        options: Options(
          headers: <String, String>{
            'Accept': '*/*',
            'Authorization': auth,
            'User-Agent': 'redditech-final/0.1 by NemesisX1',
          },
        ),
      );

      if ((res.data as Map<String, dynamic>).containsKey('error') ||
          res.statusCode! > 400) {
        throw Exception('Invalid auth data');
      } else {
        token = Token.fromJson(res.data);
      }
    } catch (e) {
      log(e.toString());
    }

    return token;
  }

  Future<Token?> refreshToken() async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    Token? token = _localService.readData<Token>(
      HiveClassName.token,
    );

    try {
      final res = await _dio.post(
        tokenUrl,
        data: FormData.fromMap(
          {
            'grant_type': 'refresh_token',
            'refresh_token': token!.refreshToken,
          },
        ),
        options: Options(
          headers: <String, String>{
            'Accept': '*/*',
            'Authorization': auth,
            'User-Agent': 'redditech-final/0.1 by NemesisX1',
          },
        ),
      );

      if ((res.data as Map<String, dynamic>).containsKey('error') ||
          res.statusCode! > 400) {
        throw Exception('Invalid auth data');
      } else {
        token = Token.fromJson(res.data);
      }
    } catch (e) {
      log(e.toString());
    }

    return token;
  }
}
