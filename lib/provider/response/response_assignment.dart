import 'dart:convert';

import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';

import '../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';

class ResponseAssignment {
  OTrnLdvHeader? oheader;
  ITrnLdvHeader? iheader;
  List<ITrnLdvDetail>? idetails;
  List<OTrnLdvDetail>? odetails;
  List<TrnRVCollComment>? rvColls;
  ResponseAssignment({
    this.oheader,
    this.iheader,
    this.idetails,
    this.odetails,
    this.rvColls,
  });

  Map<String, dynamic> toMap() {
    return {
      'oheader': oheader?.toMap(),
      'iheader': iheader?.toMap(),
      'idetails': idetails?.map((x) => x.toMap()).toList(),
      'odetails': odetails?.map((x) => x.toMap()).toList(),
      'rvColls': rvColls?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseAssignment.fromMap(Map<String, dynamic> map) {
    return ResponseAssignment(
      oheader: map['oheader'] != null ? OTrnLdvHeader.fromMap(map['oheader']) : null,
      iheader: map['iheader'] != null ? ITrnLdvHeader.fromMap(map['iheader']) : null,
      idetails: map['idetails'] != null
          ? List<ITrnLdvDetail>.from(map['idetails']?.map((x) => ITrnLdvDetail.fromMap(x)))
          : null,
      odetails: map['odetails'] != null
          ? List<OTrnLdvDetail>.from(map['odetails']?.map((x) => OTrnLdvDetail.fromMap(x)))
          : null,
      rvColls: map['rvColls'] != null
          ? List<TrnRVCollComment>.from(map['rvColls']?.map((x) => TrnRVCollComment.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseAssignment.fromJson(String source) => ResponseAssignment.fromMap(json.decode(source));
}
