import 'dart:convert';

import '../../model/masters.dart';
import 'page.dart';

class ResponseMstLdvReason {
  Embedded? embedded;
  Page? page;

  ResponseMstLdvReason({this.embedded, this.page});

  @override
  String toString() => 'ResponseMstLdvReason(embedded: $embedded, page: $page)';

  factory ResponseMstLdvReason.fromMap(Map<String, dynamic> data) => ResponseMstLdvReason(
        embedded: data['_embedded'] == null ? null : Embedded.fromMap(data['_embedded'] as Map<String, dynamic>),
        page: data['page'] == null ? null : Page.fromMap(data['page'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_embedded': embedded?.toMap(),
        'page': page?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseMstLdvReason].
  factory ResponseMstLdvReason.fromJson(String data) =>
      ResponseMstLdvReason.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [ResponseMstLdvReason] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Embedded {
  List<MstLdvDelqReason>? data;

  Embedded({this.data});

  @override
  String toString() => 'Embedded(data: $data)';

  factory Embedded.fromMap(Map<String, dynamic> data) => Embedded(
        data: (data['mst-delq-reasons'] as List<dynamic>?)
            ?.map((e) => MstLdvDelqReason.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'mst-delq-reasons': data?.map((e) => e.toJson()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Embedded].
  factory Embedded.fromJson(String data) => Embedded.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [Embedded] to a JSON string.
  String toJson() => json.encode(toMap());
}
