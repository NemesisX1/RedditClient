// URL where I get the token
import 'package:dio/dio.dart';

const baseUrl = 'https://www.reddit.com/api/v1/';
// URL from where I fetch data
const oauthBaseUrl = 'https://oauth.reddit.com/api/v1';

final dio = Dio(
  BaseOptions(baseUrl: oauthBaseUrl),
);
