import '../model/mc_trn_rvcollcomment.dart';
import 'commons.dart';
import 'time_util.dart';

class LdvUtil {
  static bool isCloseBatch(String? value) => value != null && value == 'Y';
  // static bool isLKPHeaderClosed(TrnLKPHeader header) => isCloseBatch(header.closeBatch);
  // static bool isVisited(TrnLKPDetail? dataLKPDetail) =>
  //     dataLKPDetail != null && (dataLKPDetail.workStatus != 'A' && dataLKPDetail.workStatus != null);
  static bool isVisited_(dynamic data) => data != null && (data.workStatus != 'A' && data.workStatus != null);
  // static bool isPaidViaExternalChannel(TrnLKPDetail? dataLKPDetail) =>
  //     dataLKPDetail != null && dataLKPDetail.workStatus == 'W';
  static bool isPaidViaExternalChannel_(dynamic data) => data != null && data.workStatus == 'W';
  static bool isPaymentCancelled(TrnRVCollComment? obj) =>
      obj != null && (obj.cancelRequest == '2' || !Utility.isEmpty(obj.cancelledApprove));

  // contain information of how many visit in a day of working collector.
  static String generateRVCollNo(DateTime ldvDate, String userId) =>
      '${TimeUtil.convertDateToDDMMYYYY(ldvDate)}$userId';
}
