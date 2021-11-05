import 'dart:async';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:redditech/helpers/constants.dart';
import 'package:redditech/helpers/enums.dart';
import 'package:redditech/viewmodels/login.viewmodel.dart';
import 'package:redditech/views/base.view.dart';
import 'package:redditech/views/home/home.view.dart';
import 'package:redditech/views/login/widget/auth_webview.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/png/logo.svg',
                  width: 200,
                ),
                const Gap(20),
                Text(
                  "The Redditech",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await _handleRedirectUri(model.login).then((value) {
                          if (model.isLogIn) {
                            Timer(
                              const Duration(milliseconds: 500),
                              () {
                                Navigator.of(context)
                                    .pushNamed(HomeView.routeName);
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Une erreur est survenue: vous n'êtes pas connecté"),
                            ));
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            "Une erreur est survenue: ${e.toString()}",
                          )),
                        );
                      }
                    },
                    child: model.state == ViewState.Idle
                        ? const Text(
                            "Se Connecter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
                const Gap(50),
                const Text(
                  'Made with 💓 by Kendall && Junior',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRedirectUri(Function(String) callback) async {
    try {
      await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthWebView(),
        ),
      ).then((value) {
        callback(value!);
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
