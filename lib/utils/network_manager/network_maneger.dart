import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

class TNetworkManager extends GetxController{
  static TNetworkManager get instance => Get.find();

  final Connectivity connectivity = Connectivity();
  late StreamSubscription connectivitySubscription;
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;

  void onInit(){
    super.onInit();
    connectivitySubscription = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Use results[0] or loop through them
      _updateConnectionStatus(results.first); // if you want the first result
    });

  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
    if(connectionStatus.value == ConnectivityResult.none){
      Loaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  Future<bool> isConnected() async {
    try{
      final result = await connectivity.checkConnectivity();
      if(result == ConnectivityResult.none){
        return false;
      }
      else{
        return true;
      }
    } on PlatformException catch(_){
      return false;
    }
  }

  void onClose(){
    super.onClose();
    connectivitySubscription.cancel();
  }

}