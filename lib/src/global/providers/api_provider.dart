import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:compairifuel/src/global/model/access_token.dart';
import 'package:compairifuel/src/global/typedefs.dart';

class ApiService {
  ApiService();

  AccessTokenModel? accessToken;
  DateTime? expirationDate;
  String? authorizationCode;
  final String host = "http://localhost:8080";
  final String prefix = "";
  final String redirectUri = "http://localhost:8080/oauth/callback";

  Future<void> _init() async {
    var clientInstance = Client();
    try {
      Response response = await clientInstance.get(Uri.parse(
          '$host$prefix/oauth/?response_type=code&state={}&code_challenge=2369850d2ab1338387f111660c108329b2cc66ca5f30e872ef7ca24d79b66347&redirect_uri=$redirectUri'));
      debugPrint(response.statusCode.toString());
      debugPrint(response.request.toString());
      debugPrint(response.isRedirect.toString());
      debugPrint(response.body.toString());

      authorizationCode = (jsonDecode(response.body) as Json)["code"];

      accessToken = AccessTokenModel.fromJson(jsonDecode(
          (await clientInstance.post(Uri.parse(
                  '$host$prefix/oauth/token?grant_type=authorization_code&code=$authorizationCode&code_verifier=YWJjc2Rhc2Rhc2Fkc2Fkc2Fkc2FkZHNhc2Fkc2Fkc2Rhc2Rhc2Fkc2Fkc2Fkc2Fkc2Fkc2Fkc2Fk&redirect_uri=$redirectUri')))
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

      var uri = Uri.parse("$host$prefix$endpoint");
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
                      '$host$prefix/oauth/refresh?grant_type=refresh_token&refresh_token=${accessToken!.refreshToken}&code_verifier=YWJjc2Rhc2Rhc2Fkc2Fkc2Fkc2FkZHNhc2Fkc2Fkc2Rhc2Rhc2Fkc2Fkc2Fkc2Fkc2Fkc2Fkc2Fk')))
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
