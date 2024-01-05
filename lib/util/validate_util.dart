import 'package:get/get.dart';

class ValidateUtil {
  static String? notEmpty(dynamic value) => value == null ? 'Field Required' : null;

  static String? userId(String? value) {
    if (null == value) return null;
    if (GetUtils.isLengthLessThan(value, 4)) return 'User ID too short';
    if (value.length > 20) return 'User ID too long';
    return null;
  }

  static String? password(String? value) {
    if (null == value) return null;
    if (GetUtils.isLengthLessThan(value, 5)) {
      return 'Password too short';
    }
    if (value.length > 20) return 'Password too long';
    return null;
  }

  static String? nik(String? value) {
    if (value == null) return null;
    if (GetUtils.isLengthLessThan(value, 4)) return 'NIK terlalu pendek';
    if (value.length > 20) return 'NIK terlalu panjang';
    return null;
  }

  // static UserModel? needLoggedUser() {
  //   var loggedUser = PrefController.instance.getLoggedUser();
  //   if (loggedUser == null) {
  //     showToast("You're not logged on.");
  //     return null;
  //   }
  //   return loggedUser;
  // }

  static String? validateRepoStatus(String? status) {
    if (status?.isEmpty ?? true) {
      return 'Pilih Status';
    }
    return null;
  }

  /// RULES: extend Status hanya diisi jika repo status FAILED
  static String? validateExtendStatus(String? status) {
    if (status?.isEmpty ?? true) {
      return 'Pilih Status';
    }
    return null;
  }
}
