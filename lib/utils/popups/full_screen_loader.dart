import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/popups/animation_loader.dart';


class TFullScreenLoader{

  static void openLoadingDialog(String text, String animation){

    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
            child: Container(
              color: THelperFunction.isDarkMode(Get.context!) ? Colors.black : Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 250,),
                  TAnimationLoader(text: text, animation: animation),
                ],
              ),
            )
        )
    );

  }

  static void stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }

}