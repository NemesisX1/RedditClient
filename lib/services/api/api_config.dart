// ignore: constant_identifier_names
import 'package:dio/dio.dart';

// URL where I get the token
const BASE_URL = 'https://www.reddit.com/api/v1/';
// URL from where I fetch data
const OAUTH_BASE_URL = 'https://oauth.reddit.com/api/v1/me';

const TEST_LOGIN = {
  'grant_type': 'password',
  'username': 'NemesisX10',
  'password': 'ZanarkandFF10'
};

// ignore: constant_identifier_names
const SECRET_KEY = 'PoeGTlLR9KNgSkP53fe30w';
// ignore: constant_identifier_names
const CLIENT_ID = 'reditech-nemkd';

final dio = Dio(BaseOptions(
  baseUrl: BASE_URL,
));
