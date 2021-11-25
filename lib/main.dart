// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redditech/helpers/constants.dart';
import 'package:redditech/models/token.model.dart';
import 'package:redditech/viewmodels/app.viewmodel.dart';
import 'package:redditech/viewmodels/login.viewmodel.dart';
import 'locator.dart';
import 'routes.dart';

/// [globalInitializer()]
/// Function to initialise all the pre-app things
globalInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(TokenAdapter());
  await Hive.openBox<Token>("token");
  await dotenv.load(fileName: ".env");
}

void main() async {
  await globalInitializer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => AppViewModel()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme = ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 10,
        ),
      ),
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: kViolet),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      colorScheme: const ColorScheme.light(
        primary: kViolet,
        primaryVariant: kAccentViolet,
        secondary: kPink,
        secondaryVariant: kRed,
      ),
    );

    ThemeData darkTheme = ThemeData(
      fontFamily: 'Poppins',
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        primaryVariant: Colors.black54,
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => AppViewModel(),
      child: Consumer<AppViewModel>(
        builder: (_, model, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Redditech',
            theme: model.isDarKMode ? darkTheme : lightTheme,
            onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          );
        },
      ),
    );
  }
}
