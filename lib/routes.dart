import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redditech/views/home/home.view.dart';
import 'package:redditech/views/login/login.view.dart';
import 'package:redditech/views/profile/profile.view.dart';
import 'package:redditech/views/splash/splash.view.dart';
import 'package:redditech/views/subreddit/subreddit.view.dart';
import 'helpers/empty.view.dart';

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
      case ProfileView.routeName:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => ProfileView(
            data: args,
          ),
        );
      case SubredditView.routeName:
        final args = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => SubredditView(
            subredditName: args,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return EmptyView();
          },
        );
    }
  }
}
