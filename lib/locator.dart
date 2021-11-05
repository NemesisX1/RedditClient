import 'package:get_it/get_it.dart';
import 'package:redditech/helpers/empty.view.dart';
import 'package:redditech/viewmodels/home.viewmodel.dart';
import 'package:redditech/viewmodels/profil.view.dart';
import 'package:redditech/viewmodels/subreddit.viewmodel.dart';
import 'services/local/local.service.dart';
import 'viewmodels/login.viewmodel.dart';
import 'package:redditech/services/api/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Here you register all your services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => LocalService());

  // Here you register all your viewmodels
  locator.registerFactory(() => ProfilViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => SubredditViewModel());
  locator.registerFactory(() => EmptyViewModel());
}
