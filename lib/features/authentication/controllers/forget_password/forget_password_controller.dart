import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/authentication/screens/reset_password.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';
import '../../../../utils/network_manager/network_maneger.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetMail() async {
    try{
      // send Reset Password Mail
      TFullScreenLoader.openLoadingDialog('Processing your request...', TImages.searchingAnimation);

      // Check Internet Connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
        return;
      }

      // Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // show success screen
      Loaders.successSnackBar(title: 'Email Send', message: 'Email link send to reset your password');

      // Redirect
      Get.to(() => TResetPasswordScreen(email: email.text.trim()));

    }
    catch (e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetMail(String email) async {
    try{
      // send Reset Password Mail
      TFullScreenLoader.openLoadingDialog('Processing your request...', TImages.searchingAnimation);

      // Check Internet Connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
        return;
      }

      // send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // show success screen
      Loaders.successSnackBar(title: 'Email Send', message: 'Email link send to reset your password');

      // Redirect


    }
    catch (e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}