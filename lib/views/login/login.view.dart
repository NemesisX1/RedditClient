import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:redditech/helpers/enums.dart';
import 'package:redditech/viewmodels/login.viewmodel.dart';
import 'package:redditech/views/base.view.dart';
import 'package:redditech/views/home/home.view.dart';
import 'package:redditech/views/widgets/custom_text_field.widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _userNameController,
                        labelText: "Nom d'utilisateur",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champs ne peut être vide';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      CustomTextField(
                        isSecret: true,
                        controller: _passwordController,
                        labelText: "Mot de passe",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champs ne peut être vide';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await model
                            .login(
                          _userNameController.text,
                          _passwordController.text,
                        )
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                model.isLogIn
                                    ? 'Vous êtes connecté'
                                    : "Mauvais identifiants",
                              ),
                            ),
                          );
                          if (model.isLogIn) {
                            Navigator.of(context).pushNamed(HomeView.routeName);
                          }
                        });
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
        ),
      );
    });
  }
}
