import 'package:hive/hive.dart';
import 'package:redditech/models/base.model.dart';

part 'token.model.g.dart';

@HiveType(typeId: 1)
class Token extends HiveObject implements BaseModel {
  @HiveField(0)
  String? accessToken;
  @HiveField(1)
  String? tokenType;
  @HiveField(2)
  int? createdAt;
  @HiveField(3)
  int? expiresIn;
  @HiveField(4)
  String? scope;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.createdAt,
    required this.scope,
  });

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    createdAt = DateTime.now().millisecondsSinceEpoch * 1000;
    scope = json['scope'];
  }

  Token.empty() {
    accessToken = '';
    tokenType = '';
    expiresIn = 0;
    createdAt = 0;
    scope = '';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['created_at'] = createdAt;
    data['scope'] = scope;
    return data;
  }

  bool get hasExpired {
    int expireTime = createdAt! + expiresIn!;
    int currentTime = DateTime.now().millisecondsSinceEpoch * 1000;

    return expireTime > currentTime ? false : true;
  }

  bool get isEmpty {
    if (accessToken! == '') {
      return true;
    }
    return false;
  }
}
