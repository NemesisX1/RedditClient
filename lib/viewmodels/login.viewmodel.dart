import 'dart:developer';

import 'package:redditech/helpers/enums.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/appuser.model.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/local/local.service.dart';

import 'base.viewmodel.dart';
import 'package:redditech/services/api/api.dart';

class LoginViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _localService = locator<LocalService>();

  Future<void> login(String username, String password) async {
    setState(ViewState.Busy);
    try {
      AppUser user = AppUser(username: username, password: password);
      Token? token = await _api.getToken(user);
      log(token.toJson().toString());
      if (!token.isEmpty) {
        await _localService.save<Token>(token, HiveClassName.token);
        await _localService.save<AppUser>(user, HiveClassName.user);
      }
      if (token.isEmpty) log("token is empty");
    } catch (e) {
      log("LoginViewModel: login :" + e.toString());
    }
    setState(ViewState.Idle);
  }

  bool get isLogIn {
    bool isLogin = true;

    try {
      Token? token = _localService.readData<Token>(HiveClassName.token);
      if (token!.isEmpty) isLogin = false;
      _localService.readData<AppUser>(HiveClassName.user);
    } catch (e) {
      log(e.toString());
      isLogin = false;
    }

    return isLogin;
  }

  logout() {
    try {
      _localService.deleteBoxes(HiveClassName.token);
      _localService.deleteBoxes(HiveClassName.user);
    } catch (e) {
      log(e.toString());
    }
  }
}
