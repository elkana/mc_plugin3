import 'dart:convert';

import '../../model/masters.dart';
import 'page.dart';

class ResponseMstPersonal {
  Embedded? embedded;
  Page? page;

  ResponseMstPersonal({this.embedded, this.page});

  @override
  String toString() => 'ResponseMstPersonal(embedded: $embedded, page: $page)';

  factory ResponseMstPersonal.fromMap(Map<String, dynamic> data) => ResponseMstPersonal(
        embedded: data['_embedded'] == null ? null : Embedded.fromMap(data['_embedded'] as Map<String, dynamic>),
        page: data['page'] == null ? null : Page.fromMap(data['page'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_embedded': embedded?.toMap(),
        'page': page?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseMstPersonal].
  factory ResponseMstPersonal.fromJson(String data) =>
      ResponseMstPersonal.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [ResponseMstPersonal] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Embedded {
  List<MstLdvPersonal>? data;

  Embedded({this.data});

  @override
  String toString() => 'Embedded(data: $data)';

  factory Embedded.fromMap(Map<String, dynamic> data) => Embedded(
        data: (data['mst-personal'] as List<dynamic>?)
            ?.map((e) => MstLdvPersonal.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'mst-personal': data?.map((e) => e.toJson()).toList(),
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
