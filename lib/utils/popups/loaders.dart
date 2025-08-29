import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';

class Loaders{

  static successSnackBar({required title, message = ''}){
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: ColorsData.blue,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        margin: EdgeInsets.all(10),
        icon: Icon(Iconsax.check, color: Colors.white,)
    );
  }


  static warningSnackBar({required title, message = ''}){
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      margin: EdgeInsets.all(20),
      icon: Icon(Iconsax.warning_2, color: Colors.white,)
    );
  }

  static errorSnackBar({required title, message = ''}){
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        margin: EdgeInsets.all(20),
        icon: Icon(Iconsax.warning_2, color: Colors.white,)
    );
  }

}