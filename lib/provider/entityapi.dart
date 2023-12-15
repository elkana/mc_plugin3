import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';

import '../util/commons.dart';
import 'mediaapi.dart';
import 'request_batch.dart';

class EntityApi extends MediaApi {
  // to avoid confusion, this request only needed by monitoring
  // Future<OTrnLdvHeader> get outboundLdvHeader async {
  //   var _ = await get('/mc-api/v1-ldv-headers-outbound/search/by-lastDate',
  //       q: {'collId': AuthController.instance.loggedUserId});
  //   return OTrnLdvHeader.fromMap(_);
  // }

  // Future<List<OTrnLdvDetail>?> outboundLdvDetails(String? ldvNo) async {
  //   var _ = await get('/mc-api/v1-ldv-details-outbound/search/by-ldvNo', q: {'ldvNo': ldvNo});
  //   return ResponseOLdvDetails.fromMap(_).embedded?.data;
  // }

  // Future setTrnRVCollComment(List<TrnRVCollComment> list) async {
  //   var _ = await post('/mc-api/v1-trn-rvcollcomments', data: list);
  //   log('setTrnRVCollComment = $_');
  // }

  // Future setTrnLdvDetailInbound(List<ITrnLdvDetail> list) async {
  //   var _ = await post('/mc-api/v1-trn-ldvdetail', data: list);
  //   log('setTrnLdvDetailInbound = $_');
  // }

  // Future setTrnLdvHdrInbound(ITrnLdvHeader data) async {
  //   var _ = await post('/mc-api/v1-trn-ldvdetail', data: data);
  //   log('setTrnLdvHdrInbound = $_');
  // }

  // Future<RequestBatch> setBatch() async {
  //   var data = RequestBatch()
  //     ..header = ITrnLdvHeader().findAll.firstWhereOrNull((p0) => true)
  //     ..contracts = ITrnLdvDetail().findAll
  //     ..rvColls = TrnRVCollComment().findAll;
  //   var _ = await post('/mc-api/ldv/v1-batch', data: data.toMap());
  //   return RequestBatch.fromMap(_);
  // }
}
