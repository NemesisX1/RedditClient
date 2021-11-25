import 'dart:developer';

import 'package:redditech/services/api/api.service.dart';
import '../utils/requests.dart';

class Trends {
  static const hot = 'hot';
  static const news = 'new';
  static const random = 'random';
  static const rising = 'rising';
  static const top = 'top';
}

extension Subreddits on ApiService {
  Future<Map<String, dynamic>> subreddits(
    String type, {
    int? limit,
    int? count,
  }) async {
    try {
      final res = await get(
        "/$type",
        parameters: {
          'limit': limit ?? 10,
          'count': count ?? 10,
          'show': 'all',
          'raw_json': 1,
        },
      );

      return res;
    } catch (e) {
      log(e.toString());
    }

    return {};
  }

  Future<Map<String, dynamic>> subredditInfos(String subredditName) async {
    try {
      final res = await get(
        "/$subredditName/about",
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
