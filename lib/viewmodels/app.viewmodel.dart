import 'package:redditech/viewmodels/base.viewmodel.dart';

class AppViewModel extends BaseViewModel {
  bool isDarKMode = false;

  setDarkMode() {
    isDarKMode = true;
    notifyListeners();
  }

  setLightMode() {
    isDarKMode = false;
    notifyListeners();
  }
}
