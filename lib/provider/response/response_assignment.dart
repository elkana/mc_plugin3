import 'dart:convert';

import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'page.dart';

class ResponseAssignment {
  Embedded? embedded;
  Page? page;

  ResponseAssignment({this.embedded, this.page});

  @override
  String toString() => 'ResponseAssignment(embedded: $embedded, page: $page)';

  factory ResponseAssignment.fromMap(Map<String, dynamic> data) => ResponseAssignment(
        embedded: data['_embedded'] == null ? null : Embedded.fromMap(data['_embedded'] as Map<String, dynamic>),
        page: data['page'] == null ? null : Page.fromMap(data['page'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_embedded': embedded?.toMap(),
        'page': page?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseAssignment].
  factory ResponseAssignment.fromJson(String data) =>
      ResponseAssignment.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [ResponseAssignment] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Embedded {
  List<OTrnLdvDetail>? data;

  Embedded({this.data});

  @override
  String toString() => 'Embedded(data: $data)';

  factory Embedded.fromMap(Map<String, dynamic> data) => Embedded(
        data: (data['ldv-details-outbound'] as List<dynamic>?)
            ?.map((e) => OTrnLdvDetail.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'ldv-details-outbound': data?.map((e) => e.toJson()).toList(),
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
