import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nishant_store/data/repositories/user/user_repository.dart';
import 'package:nishant_store/features/authentication/screens/login.dart';
import 'package:nishant_store/features/authentication/screens/onboarding.dart';
import 'package:nishant_store/features/authentication/screens/verify_email.dart';
import 'package:nishant_store/navigation_menu.dart';
import 'package:nishant_store/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  final auth = FirebaseAuth.instance;

  User? get authUser => auth.currentUser;

  final deviseStorage = GetStorage();

  // called from main.dart on app launch
  // this function is like onInit(), it will execute first onReady() block
  // when ever this class called
  void onReady(){
      // Remove the native splash screen
      FlutterNativeSplash.remove();
      //  Redirect to appropriate directory
      screenRedirect();
  }

  // function to show relevant screen
   screenRedirect() async{
    //FirebaseAuth.instance.setLanguageCode('en');
    final user = auth.currentUser;

    // this condition check user is login or not
     if(user != null){

       // self Edited for testing
       final email = user.emailVerified;
       final isEmail = !email;
       if(isEmail){
         // initialize user specific storage
         await TLocalStorage.init(user.uid);

         // if the user email in verified, navigate to Navigation menu
         Get.offAll(() => TNavigationMenuScreen());
       }
       // if(user.emailVerified){
       // if the user email in verified, navigate to Navigation menu
       //   Get.offAll(() => TNavigationMenuScreen());
       // }
       else{
         // if the user email in not verify, navigate to verification screen
         Get.offAll(() => TVerifyEmailScreen(email: user.email!));
       }
     }
     else{
       // Local Storage
       deviseStorage.writeIfNull('IsFirstTime', true);

       // check if first time lunching the app
       //deviseStorage.read('IsFirstTime') != true ? Get.offAll(() => LoginScreen()) : Get.offAll(() => OnBoardingScreen());
       deviseStorage.read('IsFirstTime') == true ? Get.offAll(() => OnBoardingScreen()) : Get.offAll(() => LoginScreen());

     }

   }

   /* ----------------------------------- Email & Password sign-in ------------------------------------------------ */

  // Register User
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      throw FirebaseAuthException(code: e.code);
    }
    catch (e) {
      throw 'Something went wrong in firebase while Authentication, please try again';
    }
  }

  // Mail Verification
  Future<void> sendEmailVerification() async {
    try{
      await auth.currentUser!.sendEmailVerification();
    }
    catch (e) {
      throw 'Something went wrong in firebase while sending a Email Verification, please try again';
    }
  }

  // Login User
  Future<UserCredential> loginWithEmailAndPassword( String email, String password) async {

    try{
      return await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch (e) {
      throw e.toString();
    }

  }

  // Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try{
      await auth.sendPasswordResetEmail(email: email);
    }
    catch (e) {
      throw 'Something went wrong in firebase while sending a Email Verification for forget password, please try again';
    }
  }

  // Logout user
  Future<void> logout() async {
    try{
      await GoogleSignIn.instance.signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    }
    catch (e) {
      throw 'Something went wrong in firebase while Logout, please try again';
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    try{
      // Remover data from database
      await UserRepository.instance.removeUserRecord(auth.currentUser!.uid);
      // Remove data from Authentication
      await auth.currentUser?.delete();
    }
    catch (e) {
      throw e.toString();
    }
  }

  // Re-Authenticate User
  Future<void> reAuthenticateUserAccount(String email, String password) async {
    try{
      // create Credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await auth.currentUser!.reauthenticateWithCredential(credential);
    }
    catch (e) {
      throw e.toString();
    }
  }


  // Google Authentication
  Future<UserCredential> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      //final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAccount? userAccount = await GoogleSignIn.instance.authenticate();

      // Obtain the auth details from the request.
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential.
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken
      );

      // Sign in to Firebase with the Google credential.
      return await auth.signInWithCredential(credential);

    }
    catch (e) {
      throw e.toString();
    }
  }

}