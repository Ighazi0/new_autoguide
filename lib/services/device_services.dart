import 'dart:developer';
import 'dart:ui';
import 'package:autoguide/data/keys_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

enum DeviceType { phone, smallTablet, largeTablet }

class DeviceServices {
  final cacheDuration = Duration(hours: 1);
  final getStorage = GetStorage();

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

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void cacheData(String key, dynamic data) {
    getStorage.write(key, {
      KeysData.data: data,
      KeysData.timestamp: DateTime.now().millisecondsSinceEpoch,
    });
  }

  void removeCacheByKey(String key) {
    getStorage.remove(key);
  }

  getcachedData(String key) {
    final cachedData = getStorage.read(key);
    if (cachedData != null) {
      final int timestamp = cachedData[KeysData.timestamp];
      if (DateTime.now().millisecondsSinceEpoch - timestamp <
          cacheDuration.inMilliseconds) {
        log("Returning cached response 🔄 $key");
        return cachedData[KeysData.data];
      } else {
        log("Remove cached response 🗑️ $key");
        removeCacheByKey(key);
        return null;
      }
    } else {
      return null;
    }
  }
}
