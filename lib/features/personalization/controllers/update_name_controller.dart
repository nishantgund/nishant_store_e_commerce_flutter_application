import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/user/user_repository.dart';
import 'package:nishant_store/features/personalization/controllers/user_controller.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_profile_card.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';

import '../../../utils/network_manager/network_maneger.dart';
import '../../../utils/popups/loaders.dart';

class TUpdateNameController extends GetxController{
  static TUpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  void onInit(){
    initializeName();
    super.onInit();
  }

  // Fetch User Record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  // Update User name
  Future<void> updateUserName() async {
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are Updating your information...', TImages.searchingAnimation);

      // Check Internet Connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
        return;
      }

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user firstName & lastName in Firebase FireStore
      Map<String, dynamic> name = {'FirstName' : firstName.text.trim(), "LastName" : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // update the RX user Value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulation', message: 'Your Name has been Updated');

      // Move to previous Screen
      Get.off(() =>  TProfileCard());

    }
    catch(e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

}