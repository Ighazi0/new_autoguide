import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormatServices {
  static Timestamp convertStringToTimestamp(dynamic time) {
    DateTime dateTime;
    if (time is Timestamp) {
      return time;
    } else {
      dateTime = DateTime.tryParse(time ?? '') ?? DateTime.now();
      return Timestamp.fromDate(dateTime);
    }
  }

  static String removeEmptySpaces(String? text) {
    return text?.replaceAll(' ', '') ?? '';
  }

  static String dateWithTimeFormat(String? date) {
    return DateFormat(
      "yyyy-MM-dd hh:mm a",
    ).format(DateTime.parse(date ?? DateTime.now().toIso8601String()));
  }

  static String dateFormat(String? date) {
    return DateFormat(
      "yyyy-MM-dd",
    ).format(DateTime.parse(date ?? DateTime.now().toIso8601String()));
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  static bool isPhone(String text) {
    final phoneRegex = RegExp(r'^\d+$');
    return text.isEmpty || phoneRegex.hasMatch(text);
  }

  static String formatPrice(double number, {int type = 0}) {
    if (type == 0) {
      return number.round().toInt().toString();
    } else {
      if (type == -1) {
        return number.truncate().toString();
      } else {
        if ((double.tryParse(number.toString().split('.')[1]) ?? 0) == 0) {
          return '.00';
        } else {
          return '.${FormatServices.formatPrice(double.tryParse(number.toString().split('.')[1]) ?? 0)}0';
        }
      }
    }
  }

  static String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < farsi.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    return input;
  }

  static String searchFilter(String? input) {
    return input
        .toString()
        .toLowerCase()
        .trim()
        .replaceAll(' ', '')
        .replaceAll('أ', 'ا')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ى');
  }
}
