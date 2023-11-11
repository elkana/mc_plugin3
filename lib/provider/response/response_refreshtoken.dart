import 'dart:convert';

class ResponseRefreshToken {
  String? accessToken;
  String? refreshToken;
  ResponseRefreshToken({
    this.accessToken,
    this.refreshToken,
  });
  Map<String, dynamic> toMap() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
  factory ResponseRefreshToken.fromMap(Map<String, dynamic> map) => ResponseRefreshToken(
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
      );
  String toJson() => json.encode(toMap());
  factory ResponseRefreshToken.fromJson(String source) => ResponseRefreshToken.fromMap(json.decode(source));
  @override
  String toString() => 'ResponseRefreshToken(accessToken: $accessToken, refreshToken: $refreshToken)';
}
