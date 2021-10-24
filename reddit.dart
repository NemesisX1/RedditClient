// ignore: constant_identifier_names
import 'package:dio/dio.dart';
import 'dart:convert';

// URL where I get the token
const BASE_URL = 'https://www.reddit.com/api/v1/';
// URL from where I fetch data
const OAUTH_BASE_URL = 'https://oauth.reddit.com/api/v1/me';

const TEST_LOGIN = {
  'grant_type': 'authorization_code',
  'code': 'TprU40-yMMK4FuoWQtWUdRtVW8N2lg',
  'redirect_uri': 'https://www.twitter.com/juniormedehou_',
};

// ignore: constant_identifier_names
const SECRET_KEY = 'MMMSpIb20phoGAt4pxVjKCYZdOmHMQ';
// ignore: constant_identifier_names
const CLIENT_ID = 'Az-vOK6dPexd1UlQxumtNA';

final dio = Dio();

main(List<String> args) async {
  final tokenEndpoint = Uri.parse('https://www.reddit.com/api/v1/access_token');

  final username = 'NemesisX10';
  final password = 'ZanarkandFF10';

  // In order to get the first access token when you get your
  // CODE.
  // final res = await dio.post(
  //   'https://www.reddit.com/api/v1/access_token',
  //   data: FormData.fromMap({
  //     'grant_type': 'authorization_code',
  //     'code': 'TprU40-yMMK4FuoWQtWUdRtVW8N2lg', // this is your code part
  //     'redirect_uri': 'https://www.twitter.com/juniormedehou_',
  //   }),
  //   options: Options(
  //     headers: <String, String>{
  //       'Accept': '*/*',
  //       'Authorization': auth,
  //     },
  //   ),
  // );

  var auth = 'Basic ' + base64Encode(utf8.encode('$CLIENT_ID:$SECRET_KEY'));

  final res = await dio.post(
    'https://www.reddit.com/api/v1/access_token',
    data: FormData.fromMap({
      'grant_type': 'refresh_token',
      'refresh_token': '597206709858-aKDbBnfEx6-dvKeMnIbGb1tnFuik8Q',
    }),
    options: Options(
      headers: <String, String>{
        'Accept': '*/*',
        'Authorization': auth,
        'bearer': ''
      },
    ),
  );

  // ignore: avoid_print
  print(res.data);
}
