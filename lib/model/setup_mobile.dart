import 'dart:convert';

class MobileSetup {
  String? key;
  String? value1;
  String? value2;
  String? value3;
  String? effectiveDate;
  MobileSetup({
    this.key,
    this.value1,
    this.value2,
    this.value3,
    this.effectiveDate,
  });

  Map<String, dynamic> toMap() => {
        'key': key,
        'value1': value1,
        'value2': value2,
        'value3': value3,
        'effectiveDate': effectiveDate,
      };

  factory MobileSetup.fromMap(Map<String, dynamic> map) => MobileSetup(
        key: map['key'],
        value1: map['value1'],
        value2: map['value2'],
        value3: map['value3'],
        effectiveDate: map['effectiveDate'],
      );

  String toJson() => json.encode(toMap());

  factory MobileSetup.fromJson(String source) => MobileSetup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MobileSetup(key: $key, value1: $value1, value2: $value2, value3: $value3, effectiveDate: $effectiveDate)';
  }
}
