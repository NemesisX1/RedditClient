import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:redditech/services/api/api.service.dart';

const oauthBaseUrl = 'https://oauth.reddit.com/api/v1';

final dio = Dio(
  BaseOptions(
    baseUrl: oauthBaseUrl,
  ),
);

extension Get on ApiService {
  get(String path) {
    try {
      final res = dio.get(path);
    } catch (e) {
      log(e.toString());
    }
  }

  post(String path, Map<String, dynamic> formData) {}
}
