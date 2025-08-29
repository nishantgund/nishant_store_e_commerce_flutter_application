import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/features/authentication/screens/success_screen.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';

class EmailVerificationController extends GetxController{
  static EmailVerificationController get instance => Get.find();

  void onInit(){
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // send email verification link
  sendEmailVerification() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your mail');
    }
    catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Timer and Automatically redirect on email verification success screen
  String subTitle = "Welcome to Your Ultimate Shopping Destination. Your Account is Created. Unleash the Joy of Seamless Online Shopping!";
  setTimerForAutoRedirect(){
    Timer.periodic(Duration(seconds: 1), (timer) async {
      // refresh the current user data from firebase server
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified == true){
        timer.cancel();
        Get.off(
            () => TSuccessScreen(
                image: TImages.staticSuccessIllustration,
                title: 'Your Account Successfully Created!',
                subTitle: subTitle,
                onPressed: () => AuthenticationRepository.instance.screenRedirect()
            )
        );
      }
    });
  }

  // check email verification status
  checkEmailVerificationStatus(){
    final user = FirebaseAuth.instance.currentUser;

    // Actual Code
    // if(user != null && user.emailVerified){
    //   Get.off(
    //           () => TSuccessScreen(
    //           image: TImages.staticSuccessIllustration,
    //           title: 'Your Account Successfully Created!',
    //           subTitle: subTitle,
    //           onPressed: () => AuthenticationRepository.instance.screenRedirect()
    //       )
    //   );
    // }


    // self edited
    var email;
    if(user != null){
      email = user.emailVerified;
    }

    if(!email){
      Get.off(
              () => TSuccessScreen(
              image: TImages.staticSuccessIllustration,
              title: 'Your Account Successfully Created!',
              subTitle: subTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect()
          )
      );
    }

  }

}