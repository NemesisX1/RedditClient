import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/appuser.model.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.service.dart';
import 'package:redditech/services/local/local.service.dart';

const tokenUrl = 'https://www.reddit.com/api/v1/access_token';

extension Login on ApiService {
  static final _localService = locator<LocalService>();
  static final _dio = Dio();

  Future<Token> getToken(AppUser user) async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));
    Token? token = Token.empty();

    try {
      final res = await _dio.post(
        tokenUrl,
        data: FormData.fromMap({
          "grant_type": "password",
          "username": user.username,
          "password": user.password,
        }),
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
      log("ApiService: getToken : " + e.toString());
    }

    return token!;
  }

  void refreshToken(Token token) async {
    AppUser? user = _localService.readData<AppUser>(HiveClassName.user);

    if (token.hasExpired) {
      await getToken(user!).then(
        (value) async {
          await _localService.save<Token>(value, HiveClassName.token);
        },
      );
    }
  }
}
