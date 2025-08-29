import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/data/repositories/user/user_repository.dart';
import 'package:nishant_store/features/authentication/models/user_model.dart';
import 'package:nishant_store/features/authentication/screens/login.dart';
import 'package:nishant_store/features/personalization/screens/profile/re_authenticate_user_login_form.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/network_manager/network_maneger.dart';
import '../../../utils/popups/full_screen_loader.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();


  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  void onInit(){
    super.onInit();
    fetchUserRecord();
  }

  // fetch user record
  Future<void> fetchUserRecord() async {
    try{
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    }
    catch(e) {
      user(UserModel.empty());
    }
    finally{
      profileLoading.value = false;
    }
  }

  // Save User Record
  Future<void> saveUserRecord (UserCredential? userCredential) async {

    try{

      // first update RX user and then check if user data is already stored. if not store new data
      await fetchUserRecord();

      // if no record already store
      if(user.value.id.isEmpty){

        if(userCredential != null){

          // convert name to first name and last name
          final nameParts = UserModel.nameParts(userCredential.user!.displayName ?? "");
          final userName = UserModel.generateUsername(userCredential.user!.displayName ?? "");

          // Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userame: userName,
            email: userCredential.user!.email ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            profilrPicture: userCredential.user!.photoURL ?? "",
          );

          // Save user record
          await UserRepository.instance.saveUserRecord(user);

        }
      }
    }
    catch (e) {
      Loaders.warningSnackBar(title: 'Data Not Saved');
    }
  }

  // Delete Account Warning
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: 'Delete Account',
      middleText:
        'Are you sure you want delete Account Permanently? This action is not reversible and all of your data will be remove Permanently.',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: BorderSide(color: Colors.red)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Delete'),
          )
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: Text('Cancel')
      )
    );
  }

  // Delete user Account
  void deleteUserAccount() async {
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Proceesing...', TImages.searchingAnimation);

      // First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      // Provider means = Google, Facebook, Email & Password
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        // Re Verify Auth Email
        if(provider == 'google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        }
        else if(provider == 'password'){
          TFullScreenLoader.stopLoading();
          Get.to(() => ReAuthUserLoginForm());
        }
      }
    }
    catch(e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Re Authenticate before deleting
  Future<void> reAuthenticateUserAndPassword() async {
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Proceesing...', TImages.searchingAnimation);

      // Check Internet Connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        Loaders.warningSnackBar(title: 'Please Check your Internet Connection');
        return;
      }

      // Form Validation
      if(!reAuthFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // delete Account , reauthenticate with email and Password
      await AuthenticationRepository.instance.reAuthenticateUserAccount(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());

    }
    catch(e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }

  }

  // upload profile image
  uploadUserProfilePicture() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxWidth: 512, maxHeight: 512);
      if(image != null){
        imageUploading.value = true;
        // upload Image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture' : imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilrPicture = imageUrl;
        user.refresh();
        Loaders.successSnackBar(title: 'Congratulation', message: 'your profile image has been updated');
      }
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: "Something went wrong : $e");
    }
    finally{
      imageUploading.value = false;
    }
  }


}