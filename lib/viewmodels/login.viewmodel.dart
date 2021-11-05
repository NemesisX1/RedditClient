import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:redditech/helpers/enums.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/local/local.service.dart';
import 'base.viewmodel.dart';
import 'package:redditech/services/api/api.dart';

class LoginViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _localService = locator<LocalService>();

  login(String? redirectUrl, {BuildContext? context}) async {
    //await _api.getCode(redirectUri);

    setState(ViewState.Busy);

    _api.getCode(redirectUrl);
    try {
      Token? token = await _api.getFirstToken();

      await _localService.save<Token>(
        token!,
        HiveClassName.token,
      );
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(token.toString()),
          ),
        );
      }
    } catch (e) {
      log("LoginVM: login : ${e.toString()}");
    }

    setState(ViewState.Idle);
  }

  bool get isLogIn {
    bool isLogin = true;

    if (_api.code!.isEmpty) {
      isLogin = false;
    }

    return isLogin;
  }
}
