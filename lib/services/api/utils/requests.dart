import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.service.dart';
import 'package:redditech/services/local/local.service.dart';
import 'login.dart';

const oauthBaseUrl = 'https://oauth.reddit.com/';

final dio = Dio(
  BaseOptions(
    baseUrl: oauthBaseUrl,
  ),
);

extension Requests on ApiService {
  static final _localService = locator<LocalService>();

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      Token? token = _localService.readData<Token>(HiveClassName.token);

      if (token!.hasExpired) {
        await refreshToken().then((value) {
          token = value;
          _localService.save<Token>(
            value!,
            HiveClassName.token,
          );
        }).then((value) {
          log("Refreshed");
        });
      } else {
        log("Token is ok.");
      }

      final res = await dio.get(
        path,
        queryParameters: parameters,
        options: Options(
          headers: <String, String>{
            'Accept': '*/*',
            'User-Agent': 'redditech-final/0.1 by NemesisX1',
            'Authorization': 'Bearer ${token!.accessToken}'
          },
        ),
      );

      return res.data as Map<String, dynamic>;
    } catch (e) {
      log("Requests : get : ${e.toString()}");
    }
    return {};
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> formData,
  ) async {
    try {
      Token? token = _localService.readData<Token>(HiveClassName.token);

      if (token!.hasExpired) {
        await refreshToken().then((value) {
          token = value;
          _localService.save<Token>(
            value!,
            HiveClassName.token,
          );
        }).then((value) {
          log("Refreshed");
        });
      } else {
        log("Token is ok.");
      }

      final res = await dio.post(
        path,
        data: FormData.fromMap(formData),
        options: Options(
          headers: {
            'Accept': '*/*',
            'User-Agent': 'redditech-final/0.1 by NemesisX1',
            'Authorization': 'Bearer ${token!.accessToken}'
          },
        ),
      );

      return res.data as Map<String, dynamic>;
    } catch (e) {
      log("ApiService : get : ${e.toString()}");
    }
    return {};
  }
}
