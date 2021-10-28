import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/services/local/local.service.dart';
import 'package:redditech/views/home/home.view.dart';
import 'package:redditech/views/login/login.view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const String routeName = '/';
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _localService = locator<LocalService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) screenChooser();
  }

  screenChooser() {
    return Timer(
      const Duration(
        seconds: 5,
      ),
      () {
        try {
          Token? token = _localService.readData<Token>(HiveClassName.token);
          if (token!.isEmpty) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              LoginView.routeName,
              (route) => false,
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeView.routeName,
              (route) => false,
            );
          }
        } catch (e) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginView.routeName,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
