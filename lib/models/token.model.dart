import 'package:hive/hive.dart';
import 'package:redditech/models/base.model.dart';

part 'token.model.g.dart';

@HiveType(typeId: 1)
class Token extends HiveObject implements BaseModel {
  @HiveField(0)
  String? accessToken;
  @HiveField(1)
  String? refreshToken;

  Token({
    this.accessToken,
    this.refreshToken,
  });

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
