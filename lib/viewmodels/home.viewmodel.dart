import 'dart:developer';
import 'package:redditech/helpers/enums.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/subreddit.model.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/api/api.dart';
import 'package:redditech/services/local/local.service.dart';
import 'package:redditech/viewmodels/base.viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _localService = locator<LocalService>();

  Future<Map<String, dynamic>> getMe() async {
    setState(ViewState.Busy);
    //await _api.me();
    log(_localService.readData<Token>(HiveClassName.token)!.accessToken!);
    final res = await _api.me();
    setState(ViewState.Idle);

    return res;
  }

  Future<List<Subreddit>> getSubreddits({
    int? limit,
    int? count,
    required String type,
  }) async {
    final res = await _api.subreddits(
      type,
      limit: limit,
      count: count,
    );
    log(res.toString());
    final dataList = res['data']['children'] as List;
    log("count = $count");
    List<Subreddit> subreddits = List<Subreddit>.generate(
      dataList.length,
      (index) => Subreddit.fromJson(
        dataList[index]['data'],
      ),
    );

    return subreddits;
  }
}
