import 'dart:convert';

import '../model/mc_trn_rvcollcomment.dart';
import '../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../model/trn_ldv_hdr.dart';

class RequestBatch {
  ITrnLdvHeader? header;
  List<ITrnLdvDetail>? contracts;
  List<TrnRVCollComment>? rvColls;
  RequestBatch({
    this.header,
    this.contracts,
    this.rvColls,
  });

  Map<String, dynamic> toMap() {
    return {
      'header': header?.toMap(),
      'contracts': contracts?.map((x) => x.toMap()).toList(),
      'rvColls': rvColls?.map((x) => x.toMap()).toList(),
    };
  }

  factory RequestBatch.fromMap(Map<String, dynamic> map) {
    return RequestBatch(
      header: map['header'] != null ? ITrnLdvHeader.fromMap(map['header']) : null,
      contracts: map['contracts'] != null
          ? List<ITrnLdvDetail>.from(map['contracts']?.map((x) => ITrnLdvDetail.fromMap(x)))
          : null,
      rvColls: map['rvColls'] != null
          ? List<TrnRVCollComment>.from(map['rvColls']?.map((x) => TrnRVCollComment.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestBatch.fromJson(String source) => RequestBatch.fromMap(json.decode(source));

  @override
  String toString() => 'RequestBatch(header: $header, contracts: $contracts, rvColls: $rvColls)';
}
