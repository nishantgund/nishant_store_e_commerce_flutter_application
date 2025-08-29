import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/authentication/screens/verify_email.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';
import 'package:nishant_store/utils/popups/loaders.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/network_manager/network_maneger.dart';
import '../../models/user_model.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  // Variable
  final hidePassword = true.obs;
  final privacyPolice = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFromKey = GlobalKey<FormState>();

  void signup() async {
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information....', TImages.searchingAnimation);

      // form validation
      // here validate() return true or false
      if(!signupFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // check privacy police
      if(!privacyPolice.value){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
            title: 'Accept privacy police',
            message: 'In order to create account, you must have to read and accept the privacy policy & terms of use.'
        );
        return;
      }

        // check Internet Connection
        final isConnected = await TNetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
          return;
        }

        // Register User in Firebase Authentication & Save user data in firebase
        final userId = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

        // Save authentication data in firebase FireStore database
        final newUser = UserModel(
          id: userId.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userame: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilrPicture: '',
        );

        // actual save data
        final userRepository = Get.put(UserRepository());
        userRepository.saveUserRecord(newUser);

        TFullScreenLoader.stopLoading();

        // show Success message
        Loaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to Continue');

        // Move to Verify email address
        Get.to(() => TVerifyEmailScreen(email: email.text.trim()));


    }
    catch(e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    }

  }

}
