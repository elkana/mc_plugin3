import 'dart:convert';

import '../../model/masters.dart';
import 'page.dart';

class ResponseMstNextAction {
  Embedded? embedded;
  Page? page;

  ResponseMstNextAction({this.embedded, this.page});

  @override
  String toString() => 'ResponseMstNextAction(embedded: $embedded, page: $page)';

  factory ResponseMstNextAction.fromMap(Map<String, dynamic> data) => ResponseMstNextAction(
        embedded: data['_embedded'] == null ? null : Embedded.fromMap(data['_embedded'] as Map<String, dynamic>),
        page: data['page'] == null ? null : Page.fromMap(data['page'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_embedded': embedded?.toMap(),
        'page': page?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseMstNextAction].
  factory ResponseMstNextAction.fromJson(String data) =>
      ResponseMstNextAction.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [ResponseMstNextAction] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Embedded {
  List<MstLdvNextAction>? data;

  Embedded({this.data});

  @override
  String toString() => 'Embedded(data: $data)';

  factory Embedded.fromMap(Map<String, dynamic> data) => Embedded(
        data: (data['mst-next-actions'] as List<dynamic>?)
            ?.map((e) => MstLdvNextAction.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'mst-next-actions': data?.map((e) => e.toJson()).toList(),
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
