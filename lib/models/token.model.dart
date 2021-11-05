import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:redditech/models/base.model.dart';

part 'token.model.g.dart';

@HiveType(typeId: 1)
class Token extends HiveObject implements BaseModel {
  @HiveField(0)
  String? accessToken;
  @HiveField(1)
  String? refreshToken;
  @HiveField(2)
  int? createdAt;
  @HiveField(3)
  int? expiresIn;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.createdAt,
  });

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    createdAt = DateTime.now().millisecondsSinceEpoch;
  }

  Token.empty() {
    accessToken = '';
    refreshToken = '';
    expiresIn = 0;
    createdAt = 0;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['created_at'] = createdAt;
    data['refresh_token'] = refreshToken;
    return data;
  }

  bool get hasExpired {
    int expireTime = createdAt! + expiresIn! * 1000;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    return expireTime > currentTime ? false : true;
  }

  bool get isEmpty {
    if (accessToken! == '') {
      return true;
    }
    return false;
  }
}
