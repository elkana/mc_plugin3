// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/util/time_util.dart';

import '../model/server_model.dart';
import '../model/trn_ldv_hdr.dart';
import '../provider/api.dart';

abstract class CustomLogic {
  final List<Server> servers;
  CustomLogic({required this.servers});
  // String getGoogleAPIKey();

  Future<ByteData?> get sslCertificatePem;

  Future<void> sync() async {
    // await Api.instance.setBatch();
    if (kDebugMode) await 5.delay();
  }

  Future<void> closeBatch() async {
    // 1. mark inbound header as closeBatch
    var record = InboundLdvHeader().findAll.isNotEmpty ? InboundLdvHeader().findAll.first : InboundLdvHeader();
    var outbound = OutboundLdvHeader().findAll.first;
    await InboundLdvHeader().saveOne(record
      ..collId = outbound.collId
      ..collName = outbound.collName
      ..ldvNo = outbound.ldvNo
      ..ldvDate = outbound.ldvDate
      ..officeCode = outbound.officeCode
      ..officeName = outbound.officeName
      ..closeBatch = 'Y'
      ..closeBatchDate = TimeUtil.nowIso());
    // 2. sync
    await sync();
  }
  // recommended format yyyyMMdd. return null to turn expiry off.
  // String? getExpiryApp();

  // num getTargetTagih(TrnLKPDetail ldvDtl);

  // /// return true if validated. This logic will only called when user choose janji bayar date.
  // /// so if ptpDate is null "" return false
  // bool validateJanjiBayar(DateTime ptpDate);
  // Future<String> generateStrukID(BuildContext context, String pattern, String? lastStrukID);

  // // Future printStruk(PrintData data);
  // // Future printStruk(APrinter bluetooth, PrintData data);
  // Future printStruk(BlueThermalPrinter bluetooth, PrintData data);
  // Widget buildPreviewStruk(PrintData data);
  // double splitACToPenalty(double receivedAmount, TrnLKPDetail lkpDetail);
  // double splitACToMonthInst(double receivedAmount, TrnLKPDetail lkpDetail);
  // double splitACToCollectionFee(double receivedAmount, TrnLKPDetail lkpDetail);
  // double splitACToDeposit(double receivedAmount, TrnLKPDetail lkpDetail);

  // /// return true if user agree on terms
  // Future<bool> showTerms();
}

// class ThemeUtil {
// static const font_size_flag_title = 18.0;
// static const font_size_textfield = 16.0;

// static TextStyle styleTitleAppBar = const TextStyle(
//     // letterSpacing: 1,
//     color: Colors.white,
//     fontSize: 19,
//     fontStyle: FontStyle.italic,
//     fontWeight: FontWeight.w900);

// static const styleHeaderScrollTitle =
//     TextStyle(package: MCConstants.packageNameForAssetsAccess, fontWeight: FontWeight.bold);

// static const color_workStatus_paidChannel_dark = Color(0xFF0719aa);
// static const color_workStatus_paidChannel_light = Color(0xff80ccff);
// static const color_workStatus_visited_dark = Color(0xFF124a24);
// static const color_workStatus_visited_light = Color(0xffacffb8);
// static const color_workStatus_wait2Sync_light = Color(0xffe5f329);
// static const color_workStatus_wait2Sync_dark = Color(0xff4b5104);
// static const color_paymentcancelled_dark = Color(0xff757575);
// static const color_paymentcancelled_light = Color(0xffbdbdbd);

// static const colorDocSPCircle = Color(0xffe65100); //  Colors.orange[900]
// static const colorDocSKTCircle = Color(0xffd50000); // Colors.redAccent[700];
// static const elevationCardDashboard = 4.0;

// static Color get colorPaidViaChannel =>
//     Get.isDarkMode ? color_workStatus_paidChannel_dark : color_workStatus_paidChannel_light;
// static Color get colorPaymentCancelled =>
//     !Get.isDarkMode ? color_paymentcancelled_light : color_paymentcancelled_dark;
// static Color get colorWait2Sync =>
//     !Get.isDarkMode ? color_workStatus_wait2Sync_light : color_workStatus_wait2Sync_dark;
// static Color get colorSynced => !Get.isDarkMode ? color_workStatus_visited_light : color_workStatus_visited_dark;
// static Color get colorText => !Get.isDarkMode ? Colors.black : Colors.white;

//   static inputDecoration(
//     String? hintText,
//     String? errorText,
//     bool hideCounter,
//     String label,
//     Widget? suffixIcon,
//   ) =>
//       InputDecoration(
//           filled: true,
//           fillColor: Colors.blueGrey.shade50,
//           hintText: hintText,
//           errorText: errorText,
//           counterText: hideCounter ? '' : null,
//           border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
//           errorBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.red, width: 1)),
//           errorStyle: const TextStyle(fontSize: 11),
//           labelText: label,
//           hintStyle: const TextStyle(fontSize: 12),
//           labelStyle: const TextStyle(fontSize: 14),
//           suffixIcon: suffixIcon,
//           contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
//           focusedBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               borderSide: BorderSide(color: Colors.orangeAccent, width: 2)));
// }

abstract class CustomTheme {
  Color get colorMain;
  // Widget get extraPaddingBottomAppBar; useless
  Widget getIconForFAB(BuildContext context);
  // AppBar getAppBar(BuildContext context, String title, {PreferredSizeWidget bottom, List<Widget> actions});
  // Text getGreetings(BuildContext context, String text);
  // CustomPainter getLoginPainter(BuildContext context);
  Widget getLoginLogo(BuildContext context);
  // Widget getDefaultLogoWhenEmpty(BuildContext context);
  // Widget btnLogin(VoidCallback onTap);
  InputDecoration getInputDecoration(
      String? hintText, String? errorText, bool hideCounter, String label, Widget? suffixIcon);
}

// need to assign first time at screen_logic
// MCScreenLogin know what to do
CustomTheme? clientTheme;
// need to assign first time at screen_logic
// MCScreenLogin know what to do
CustomLogic? clientLogic;
