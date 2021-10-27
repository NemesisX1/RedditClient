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

  Future<bool> getToken() async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    bool hasSucceed = false;

    try {
      final res = await _dio.post(
        tokenUrl,
        data: FormData.fromMap({
          'grant_type': 'authorization_code',
          'code': code, // this is your code part
          'redirect_uri': redirectUrl,
        }),
        options: Options(
          headers: <String, String>{
            'Accept': '*/*',
            'Authorization': auth,
          },
        ),
      );

      if (res.statusCode! > 400) {
        await refreshToken();
      } else {
        _localService.save<Token>(
          Token.fromJson(res.data),
          HiveClassName.token,
        );
      }
      hasSucceed = true;
    } catch (e) {
      log(e.toString());
      hasSucceed = true;
    }
    return hasSucceed;
  }

  refreshToken() async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    Token? curentToken = _localService.readData<Token>(
      HiveClassName.token,
    );
    bool hasSucceed = false;

    try {
      final res = await _dio.post(
        tokenUrl,
        data: FormData.fromMap({
          'grant_type': 'refresh_token',
          'refresh_token': curentToken!.refreshToken,
        }),
        options: Options(
          headers: <String, String>{
            'Accept': '*/*',
            'Authorization': auth,
          },
        ),
      );

      if (res.statusCode! > 400) {
      } else {
        _localService.save<Token>(
          Token.fromJson(res.data),
          HiveClassName.token,
        );
      }

      hasSucceed = true;
    } catch (e) {
      log(e.toString());
      hasSucceed = false;
    }
    return hasSucceed;
  }
}
