import 'package:redditech/models/base.model.dart';
import 'package:hive/hive.dart';
part 'appuser.model.g.dart';

@HiveType(typeId: 0)
class AppUser extends HiveObject implements BaseModel {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String? password;

  AppUser({
    required this.username,
    required this.password,
  });

  @override
  toJson() {
    return {
      "username": username,
      "password": password,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    AppUser user = AppUser(
      username: json["username"],
      password: json["password"],
    );
    return user;
  }
}
