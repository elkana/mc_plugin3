import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';

import '../util/commons.dart';
import 'mediaapi.dart';

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

  Future setTrnRVCollComment(TrnRVCollComment data) async {
    var _ = await post('/mc-api/v1-trn-rvcollcomments', data: data);
    log('setTrnRVCollComment = $_');
  }
}
