import "package:compairifuel/src/global/model/access_token.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AccessTokenModel", (){
      test("should return a AccessTokenModel from the given json", () {
        var json = {"access_token":"1234567abc","token_type":"Bearer","expires_in":100000,"refresh_token":"1234567abc"};
        var expected = AccessTokenModel(accessToken: '1234567abc', tokenType: 'Bearer', expiresIn: 100000, refreshToken: '1234567abc');

        var result = AccessTokenModel.fromJson(json);


        expect(result, equals(expected));
        expect(result.hashCode, equals(expected.hashCode));
      });
      test("should return a json of the AccessTokenModel", () {
        var sut = AccessTokenModel(accessToken: '1234567abc', tokenType: 'Bearer', expiresIn: 100000, refreshToken: '1234567abc');
        var expected = {"access_token":"1234567abc","token_type":"Bearer","expires_in":100000,"refresh_token":"1234567abc"};

        var result = sut.toJson();

        expect(result, equals(expected));
      });
  });
}