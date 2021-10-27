import 'package:redditech/locator.dart';

import 'base.viewmodel.dart';
import 'package:redditech/services/api/api.dart';

class LoginViewModel extends BaseViewModel {
  final _api = locator<ApiService>();

  login(String? redirectUrl) async {
    //await _api.getCode(redirectUri);
    _api.getCode(redirectUrl);

    _api.getToken();
  }
}
