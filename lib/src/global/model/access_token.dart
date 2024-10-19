import 'package:compairifuel/src/global/typedefs.dart';
import 'package:equatable/equatable.dart';

class AccessTokenModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;

  const AccessTokenModel(
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

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, refreshToken];
}
