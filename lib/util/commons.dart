import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'time_util.dart';

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) => cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

extension Rupiah on num? {
  String toRupiah({bool displayLabel = true}) {
    final formatCurrency = NumberFormat('#,###', 'id_ID');
    return (displayLabel ? 'Rp. ' : '') + formatCurrency.format(this ?? 0);
  }
}

void log(String msg, {StackTrace? stacktrace}) {
  if (kDebugMode) debugPrint('@${DateTime.now()} -> $msg');
  if (stacktrace != null) {
    print(stacktrace);
  }
}

void showToast(String message, {bool error = false, bool success = false, String title = ''}) {
  debugPrint('Toast => $message');
  if (error) {
    message = message.normalizeException();
  }
  Get.snackbar(title, message,
      messageText: Text(message),
      snackPosition: SnackPosition.TOP,
      backgroundColor: error
          ? Colors.red.shade800.withOpacity(0.8)
          : success
              ? Colors.green.shade700.withOpacity(0.8)
              : Colors.black.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 6);
}

void showError(Object? message, {StackTrace? stacktrace, String title = ''}) {
  if (stacktrace != null) print(stacktrace);
  showToast(message.toString(), error: true, title: title);
}

Future<bool> confirm(String message, {String title = ''}) async =>
    await showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
                title: Text(title),
                content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
                actions: <Widget>[
                  TextButton(onPressed: () => Get.back(result: false), child: const Text('Tidak')),
                  TextButton(onPressed: () => Get.back(result: true), child: const Text('Ya'))
                ])) ??
    false;

Future<void> confirmOk(String message, {String title = ''}) => showDialog(
    context: Get.context!,
    builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[TextButton(onPressed: () => Get.back(result: true), child: const Text('OK'))]));

Future<bool> exitApp() => confirm('Keluar dari Aplikasi ?');

void showMaterialBanner(String message) {
  ScaffoldMessenger.of(Get.context!).showMaterialBanner(MaterialBanner(
      content: Text(message),
      // contentTextStyle: const TextStyle(color: Colors.black, fontSize: 30),
      backgroundColor: Colors.yellow,
      leadingPadding: const EdgeInsets.only(right: 30),
      leading: const Icon(Icons.info, size: 32),
      actions: [
        TextButton(
            onPressed: () => ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner(),
            child: const Text('Dismiss')),
        // TextButton(onPressed: () {}, child: const Text('Continue')),
      ]));
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
  String toTrim(int maxLength, [String marker = '...']) =>
      trim().length > maxLength ? trim().substring(0, (maxLength - 1)) + marker : trim();
  String toInitials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.isNotEmpty && result.length < 2) {
        result += element[0];
      }
    }
    return result.trim().toUpperCase();
  }

// eliminate Exception: in the beginning
  String normalizeException() => startsWith('Exception:') ? substring('Exception: '.length, length) : this;

  DateTime isoToLocalDate() {
    // return this.toDate();
    return DateTime.parse(this).toLocal();
  }

  String isoToSimpleDate([String? pattern]) {
    if (Utility.isEmpty(this)) return '-';
    try {
      var dt = isoToLocalDate();
      // TODO maybe show past year ?
      var s = DateFormat(pattern ?? 'd MMM').format(dt);
      return s;
    } catch (e) {
      log('Cant parse iso date $this');
    }
    return '-';
  }

  // bool get isUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;
  bool get isUrl => startsWith('http');
}

// H2U: await [1, 2, 5].randomItem().delay();
extension RandomListItem<T> on List<T> {
  T get random => this[Random().nextInt(length)];
}

class Utility {
  static bool isEmpty(dynamic o) => o == null || "" == o || o.trim().isEmpty;
  static bool isNotEmpty(dynamic o) => !isEmpty(o);
  static bool isNullOrZero(int? value) => value == null || value < 1;
  static bool isEmptyList(List? list) => list == null || list.isEmpty;

  static String includePath(String path) {
    if (path.endsWith('/')) return path;
    if (path.endsWith('\\')) return path;
    return '$path/';
  }

  static bool isNumeric(String? s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }

  static String list2Csv(List<dynamic> list, String separator) {
    if (isEmptyList(list)) return '';
    var s = list[0].toString();
    for (int i = 1; i < list.length; i++) {
      s += separator + list[i].toString();
    }
    return s;
  }

  // 0.0 - 1.0
  static double getPercent(int? actual, int? total) {
    if (actual == null || total == null) return 0.0;
    if (actual > total) return 1.0;
    if (total == 0) return 0.0;
    double result = ((actual.toDouble() / total.toDouble()) * 100) / 100;
    return result;
  }

  static String eliminateFirstWord(String word, String src) =>
      (src.toLowerCase().startsWith(word)) ? src.substring(word.length, src.length) : src;

  static String uuid() => const Uuid().v4();

  static String? getFileExtension(String fileName) {
    if (!fileName.contains(".")) return null;
    var ext = ".${fileName.split('.').last}";
    log('getFileExtension($fileName) -> $ext');
    return ext;
  }

  static String getFilenameWOPath(String fileName) {
    var ret = fileName.split('/').last;
    log('getFilenameWOPath($fileName) -> $ret');
    return ret;
  }

  static bool isExpiredApp(String? expiryDate) {
    if (expiryDate == null || expiryDate.length != 8) return false;
    var now = TimeUtil.convertDateToYYYYMMDD(DateTime.now());
    var val = int.parse(now) > int.parse(expiryDate);
    log('THIS APP ${!val ? 'WILL' : 'HAS'} EXPIRED on $expiryDate -> today is $now');
    // log('THIS APP WILL EXPIRED on $expiryDate -> today is $now, val = $val');
    // return now compareTo(expiryDate) < 0;
    return val;
  }
}
