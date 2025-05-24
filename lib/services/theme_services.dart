import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/data/keys_data.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  static bool get isDarkMode =>
      (GetStorage().read(KeysData.themeMode) ?? 'light') == 'dark';

  static String get themeMode {
    return GetStorage().read(KeysData.themeMode) ?? 'light';
  }

  static Future<void> changeThemeMode() async {
    GetStorage().write(KeysData.themeMode, isDarkMode ? 'light' : 'dark');
    MainController().isDarkMode.value = isDarkMode;
  }
}
