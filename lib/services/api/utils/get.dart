import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.service.dart';
import 'package:redditech/services/local/local.service.dart';
import 'login.dart';

const oauthBaseUrl = 'https://oauth.reddit.com/api/v1';

final dio = Dio(
  BaseOptions(
    baseUrl: oauthBaseUrl,
  ),
);

extension Get on ApiService {
  static final _localService = locator<LocalService>();

  get(String path) {
    try {
      Token? token = _localService.readData<Token>(HiveClassName.token);

      if (token!.hasExpired!) {
        refreshToken(token);
      }

      final res = dio.get(
        path,
        options: Options(
          headers: <String, String>{
            'User-Agent': 'redditech-/0.1 by NemesisX1',
            'Authorization': 'Bearer ${token.accessToken}'
          },
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  post(String path, Map<String, dynamic> formData) {}
}
