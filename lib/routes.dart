import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redditech/views/login/login.view.dart';
import 'package:redditech/views/splash/splash.view.dart';
import 'helpers/empty.view.dart';
import 'views/home/home.view.dart';

/// [AppRouter]
/// This the base router classes where you can registered
/// and customize all the named routes of your app
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashView.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case LoginView.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case HomeView.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return EmptyView();
        });
    }
  }
}
