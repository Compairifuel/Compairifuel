import 'package:compairifuel/src/global/typedefs.dart';

class AccessTokenModel {
  late final String accessToken;
  late final String tokenType;
  late final int expiresIn;
  late final String refreshToken;

  AccessTokenModel(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.refreshToken});

  factory AccessTokenModel.fromJson(Json json) {
    return AccessTokenModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"]);
  }

  Json toJson() {
    Json data = {
      "access_token": accessToken,
      "token_type": tokenType,
      "expires_in": expiresIn,
      "refresh_token": refreshToken,
    };
    return data;
  }
}
