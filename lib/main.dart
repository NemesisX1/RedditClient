import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redditech/models/appuser.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'helpers/theme.dart';
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
}

void main() async {
  await globalInitializer();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: appTheme,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
    );
  }
}
