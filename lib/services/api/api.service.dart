import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redditech/services/base.service.dart';

class ApiService extends BaseService {
  String? get clientId => dotenv.get("CLIENT_ID");
  String? get clientSecret => dotenv.get("CLIENT_SECRET");
}
