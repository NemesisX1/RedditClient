import 'package:redditech/models/base.model.dart';

class User extends BaseModel {
  final String? username;
  final String? userUrl;
  final String? pictureUrl;

  User({
    this.pictureUrl,
    this.userUrl,
    this.username,
  });

  @override
  toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
