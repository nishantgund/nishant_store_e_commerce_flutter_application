import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/personalization/controllers/user_controller.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/network_manager/network_maneger.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController{
  LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  onInit(){
    super.onInit();
    // if(localStorage.hasData('Remember_Me_Email')){
    //   email.text = localStorage.read('Remember_Me_Email');
    // }
  }

  // Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try{

      // Start Loading
      TFullScreenLoader.openLoadingDialog('Login you in...', TImages.searchingAnimation);

      // Check Internet Connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
        return;
      }

      // Form Validation
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me selected
      if(rememberMe.value){
        localStorage.write('Remember_Me_Email', email);
        localStorage.write('Remember_Me_Password', password);
      }

      // Login User using Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    }
    catch(e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google SignIn
  Future<void> googleSignIn() async {

    // Start Loading
    TFullScreenLoader.openLoadingDialog('Login you in...', TImages.searchingAnimation);

    // Check Internet Connection
    final isConnected = await TNetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
      return;
    }

    // Google Authentication
    final userCredential = await AuthenticationRepository.instance.signInWithGoogle();

    // Save User Data
    await UserController.instance.saveUserRecord(userCredential);

    // Remove Loader
    TFullScreenLoader.stopLoading();

    // Redirect
    AuthenticationRepository.instance.screenRedirect();

  }

}