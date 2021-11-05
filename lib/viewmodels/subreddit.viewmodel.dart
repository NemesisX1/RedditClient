import 'dart:developer';
import 'package:redditech/helpers/enums.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/subreddit.model.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.dart';
import 'package:redditech/services/local/local.service.dart';
import 'package:redditech/viewmodels/base.viewmodel.dart';

class SubredditViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _localService = locator<LocalService>();

  Future<Map<String, dynamic>> getInfos(String subredditName) async {
    try {
      final res = await _api.subredditInfos(subredditName);

      return res['data'];
    } catch (e) {
      log(e.toString());
    }

    return {};
  }
}
