import 'package:autoguide/services/locale_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormatServices {
  static String formatElapsedTime(String time) {
    DateTime now = Timestamp.now().toDate();
    DateTime inputTime = convertFromMillisecondsSinceEpochToTimestamp(
      time,
    ).toDate();

    if (now.isBefore(inputTime)) {
      final temp = now;
      now = inputTime;
      inputTime = temp;
    }

    final duration = now.difference(inputTime);

    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).floor();
      return '$years ${years > 1 ? 'years'.tr : 'y'.tr}';
    } else if (duration.inDays >= 30) {
      final months = (duration.inDays / 30.44).floor();
      return '$months ${months > 1 ? 'months'.tr : 'month'.tr}';
    } else if (duration.inDays >= 7) {
      final weeks = (duration.inDays / 7).floor();
      return '$weeks ${'w'.tr}';
    } else if (duration.inDays > 0) {
      return '${duration.inDays} ${'d'.tr}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} ${'h'.tr}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} ${'m'.tr}';
    } else {
      return '${duration.inSeconds} ${'s'.tr}';
    }
  }

  static Timestamp convertStringToTimestamp(dynamic time) {
    DateTime dateTime;
    if (time is Timestamp) {
      return time;
    } else {
      dateTime = DateTime.tryParse(time ?? '') ?? DateTime.now();
      return Timestamp.fromDate(dateTime);
    }
  }

  static Timestamp convertFromMillisecondsSinceEpochToTimestamp(dynamic time) {
    if (time is Timestamp) {
      return time;
    } else {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(time) ?? DateTime.now().millisecondsSinceEpoch,
      );
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
