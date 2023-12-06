import '../controller/auth_controller.dart';
import '../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../model/trn_ldv_hdr.dart';
import 'mediaapi.dart';
import 'response/response_assignment.dart';

class EntityApi extends MediaApi {
  Future<OTrnLdvHeader> get outboundLdvHeader async {
    var _ = await get('/mc-api/v1-ldv-headers-outbound/search/by-lastDate',
        q: {'collId': AuthController.instance.loggedUserId});
    return OTrnLdvHeader.fromMap(_);
  }

  Future<List<OTrnLdvDetail>?> outboundLdvDetails(String? ldvNo) async {
    var _ = await get('/mc-api/v1-ldv-details-outbound/search/by-ldvNo', q: {'ldvNo': ldvNo});
    return ResponseAssignment.fromMap(_).embedded?.data;
  }
}
