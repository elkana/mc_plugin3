import 'dart:convert';

import '../../model/masters.dart';
import 'page.dart';

class ResponseMstClassification {
  Embedded? embedded;
  Page? page;

  ResponseMstClassification({this.embedded, this.page});

  @override
  String toString() => 'ResponseMstClassification(embedded: $embedded, page: $page)';

  factory ResponseMstClassification.fromMap(Map<String, dynamic> data) => ResponseMstClassification(
        embedded: data['_embedded'] == null ? null : Embedded.fromMap(data['_embedded'] as Map<String, dynamic>),
        page: data['page'] == null ? null : Page.fromMap(data['page'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_embedded': embedded?.toMap(),
        'page': page?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseMstClassification].
  factory ResponseMstClassification.fromJson(String data) =>
      ResponseMstClassification.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [ResponseMstClassification] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Embedded {
  List<MstLdvClassification>? data;

  Embedded({this.data});

  @override
  String toString() => 'Embedded(data: $data)';

  factory Embedded.fromMap(Map<String, dynamic> data) => Embedded(
        data: (data['mst-ldv-classification'] as List<dynamic>?)
            ?.map((e) => MstLdvClassification.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'mst-ldv-classification': data?.map((e) => e.toJson()).toList(),
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
