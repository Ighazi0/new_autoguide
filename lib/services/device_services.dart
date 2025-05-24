import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

enum DeviceType { phone, smallTablet, largeTablet }

class DeviceServices {
  static Future<bool?> checkIfIpad() async {
    if (Platform.isIOS) {
      return deviceSize.shortestSide >= 600;
    }
    return false;
  }

  static DeviceType get getDeviceType {
    final shortestSide = deviceSize.shortestSide;
    if (shortestSide < 600) {
      return DeviceType.phone;
    } else if (shortestSide < 750) {
      return DeviceType.smallTablet;
    } else {
      return DeviceType.largeTablet;
    }
  }

  static bool get isTablet {
    return getDeviceType == DeviceType.smallTablet ||
        getDeviceType == DeviceType.largeTablet;
  }

  static double get width {
    return deviceSize.width;
  }

  static double get height {
    return deviceSize.height;
  }

  static Size get deviceSize {
    final size =
        PlatformDispatcher.instance.views.first.physicalSize /
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return Size(screenWidth, screenHeight);
  }

  static double responsiveAspectRatio(double width, double height, int count) {
    final double childWidth = (deviceSize.width / count);
    final double childHeight = (height / width) * childWidth;
    return childWidth / childHeight;
  }

  static Size reponsiveSize(Size size, {double count = 1, double crop = 0}) {
    double scaleFactor = (deviceSize.width - crop) / (count * size.width);
    double newW = size.width * scaleFactor;
    double newH = size.height * scaleFactor;
    return Size(newW, newH);
  }

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
