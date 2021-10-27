// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redditech/models/appuser.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redditech/models/token.model.dart';
import 'locator.dart';
import 'routes.dart';

/// [globalInitializer()]
/// Function to initialise all the pre-app things
globalInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AppUserAdapter());
  await Hive.openBox<AppUser>("user");
  await Hive.openBox<Token>("token");
  await dotenv.load(fileName: ".env");
}

void main() async {
  await globalInitializer();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme = ThemeData(
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        elevation: 0,
      ),
    );

    ThemeData darkTheme = ThemeData(
      fontFamily: 'Poppins',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: lightTheme,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
    );
  }
}
