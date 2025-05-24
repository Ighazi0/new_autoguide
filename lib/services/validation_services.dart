import 'package:autoguide/services/locale_services.dart';

class ValidationServices {
  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'password_length_should_at_least_6_character'.tr;
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (password != value) {
      return 'password_not_match'.tr;
    }
    return null;
  }

  static String? name(String? value) {
    if (value!.isEmpty) {
      return 'your_full_name_is_required'.tr;
    }
    return null;
  }

  static String? email(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value ?? '')) {
      return 'please_enter_your_email'.tr;
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value!.isEmpty) {
      return 'this_field_is_required'.tr;
    }
    return null;
  }
}
