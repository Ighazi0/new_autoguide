import 'package:autoguide/app/app_assets.dart';
import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/data/keys_data.dart';
import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/device_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/views/auth/screens/login_screen.dart';
import 'package:autoguide/views/user/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigator() async {
    await Future.delayed(Durations.medium2);
    if (GetStorage().read(KeysData.token) != null) {
      MainController().userDataNotifier.value = UserModel.fromJson(
        GetStorage().read(KeysData.userData),
      );
      NavigatorServices.pushReplacement(UserScreen());
    } else {
      NavigatorServices.pushReplacement(LoginScreen());
    }
  }

  @override
  void didChangeDependencies() {
    navigator();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Center(
        child: SizedBox(
          width: DeviceServices.width / 2,
          child: Image.asset(ImagesAssets.icon, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
