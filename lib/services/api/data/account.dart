import 'dart:developer';

import 'package:redditech/services/api/api.service.dart';
import '../utils/requests.dart';

extension Account on ApiService {
  Future<Map<String, dynamic>> me() async {
    try {
      final res = await get(
        'api/v1/me',
        parameters: {
          'raw_json': 1,
        },
      );

      return res;
    } catch (e) {
      log(e.toString());
    }
    return {};
  }
}
