import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:compairifuel/src/global/model/access_token.dart';
import 'package:compairifuel/src/global/typedefs.dart';
import 'package:crypto/crypto.dart';

class ApiService {
  ApiService();

  AccessTokenModel? accessToken;
  DateTime? expirationDate;
  String? authorizationCode;
  final String host = dotenv.get("COMPAIRIFUEL_BACKEND_HOST");
  final String redirectUri = "http://localhost:8080/oauth/callback";

  Future<void> _init() async {
    var clientInstance = Client();
    try {
      Response response = await clientInstance.get(
        Uri.parse(
            '$host/oauth/?response_type=code&state={}&code_challenge=${base64UrlEncode(sha256.convert(dotenv.get("COMPAIRIFUEL_BACKEND_CODE_VERIFIER").codeUnits).bytes)}&redirect_uri=$redirectUri'),
      );

      authorizationCode = (jsonDecode(response.body) as Json)["code"];

      accessToken =
          AccessTokenModel.fromJson(jsonDecode((await clientInstance.post(
        Uri.parse('$host/oauth/token'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
        },
        body: {
          "grant_type": "authorization_code",
          "code": authorizationCode,
          "state": jsonEncode({}),
          "code_verifier": dotenv.get("COMPAIRIFUEL_BACKEND_CODE_VERIFIER"),
          "redirect_uri": redirectUri,
        },
      ))
              .body) as Json);
      if (accessToken != null) {
        expirationDate = DateTime.now().add(Duration(
            milliseconds: int.parse(accessToken!.expiresIn.toString())));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      clientInstance.close();
    }
  }

  Future<Response> get(String endpoint) async {
    var clientInstance = Client();
    try {
      await authenticate();

      var uri = Uri.parse("$host$endpoint");
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${accessToken!.accessToken}",
      };

      return await clientInstance.get(uri, headers: headers);
    } catch (e) {
      debugPrint(e.toString());
      return Response("$e", HttpStatus.internalServerError);
    } finally {
      clientInstance.close();
    }
  }

  bool isAuthenticated() {
    if (accessToken != null && expirationDate != null) {
      return DateTime.now().isBefore(expirationDate!);
    }
    return false;
  }

  Future<void> authenticate() async {
    var clientInstance = Client();
    try {
      if (accessToken != null) {
        if (!isAuthenticated()) {
          accessToken = AccessTokenModel.fromJson(jsonDecode(
              (await clientInstance.post(Uri.parse(
                      '$host/oauth/refresh?grant_type=refresh_token&refresh_token=${accessToken!.refreshToken}&code_verifier=${dotenv.get("COMPAIRIFUEL_BACKEND_CODE_VERIFIER")}')))
                  .body) as Json);
        }
      } else {
        await _init();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      clientInstance.close();
    }
  }
}

final apiProvider = FutureProvider((ref) {
  return ApiService();
});
