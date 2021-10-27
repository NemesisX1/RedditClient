import 'package:redditech/models/base.model.dart';
import 'package:hive/hive.dart';
part 'appuser.model.g.dart';

@HiveType(typeId: 0)
class AppUser extends HiveObject implements BaseModel {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String? email;

  AppUser({
    this.email,
    this.username,
  });

  @override
  toJson() {
    return {
      "username": username,
      "email": email,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    AppUser user = AppUser(
      username: json["usrname"],
      email: json["email"],
    );
    return user;
  }
}
