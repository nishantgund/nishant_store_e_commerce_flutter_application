
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../app.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../firebase_options.dart';

Future<void> main() async {

  // widget binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Getx Local Storage
  await GetStorage.init();

  // Await Splash until other item load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase and Authentication repository
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
  //     (FirebaseApp value) => Get.put(AuthenticationRepository())
  // );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug
  );

  Get.put(AuthenticationRepository());

  runApp(const App());
}