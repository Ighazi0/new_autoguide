import 'dart:developer';
import 'package:autoguide/app/firebase_options.dart';
import 'package:autoguide/app/init_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future firebaseMessagingBackgroundHandler(message) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  await GetStorage.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log('initializeApp');
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const InitApp());
}
