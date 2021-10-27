import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redditech/viewmodels/login.viewmodel.dart';
import 'package:redditech/views/base.view.dart';
import 'package:redditech/views/login/widget/auth_webview.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _handleRedirectUri(model.login);
            },
            child: const Text(
              "Se Connecter à Reddit",
            ),
          ),
        ),
      );
    });
  }

  void _handleRedirectUri(Function(String) callback) async {
    await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const AuthWebView(),
      ),
    ).then((value) {
      callback(value!);
    });
  }
}
