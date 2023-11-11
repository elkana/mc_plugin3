import 'dart:convert';

class ResponseApk {
  String? url;
  int? buildNumber;
  int? clientBuildNumber;
  String? effectiveDate;
  ResponseApk({
    this.url,
    this.buildNumber,
    this.clientBuildNumber,
    this.effectiveDate,
  });
  Map<String, dynamic> toMap() => {
        'url': url,
        'buildNumber': buildNumber,
        'clientBuildNumber': clientBuildNumber,
        'effectiveDate': effectiveDate,
      };
  factory ResponseApk.fromMap(Map<String, dynamic> map) => ResponseApk(
        url: map['url'],
        buildNumber: map['buildNumber']?.toInt(),
        clientBuildNumber: map['clientBuildNumber'],
        effectiveDate: map['effectiveDate'],
      );
  String toJson() => json.encode(toMap());
  factory ResponseApk.fromJson(String source) => ResponseApk.fromMap(json.decode(source));
  @override
  String toString() =>
      'ResponseApk(url: $url, buildNumber: $buildNumber, clientBuildNumber: $clientBuildNumber, effectiveDate: $effectiveDate)';
}
