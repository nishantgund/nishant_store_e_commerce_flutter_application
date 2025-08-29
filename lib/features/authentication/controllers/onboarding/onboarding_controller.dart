 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nishant_store/features/authentication/screens/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;


  void upadatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
    if(currentPageIndex == 2){
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(LoginScreen());
    }else{
      int index = currentPageIndex.value + 1;
      pageController.jumpToPage(index);
    }
  }

  void skipPage(){
    currentPageIndex.value = 2;
    Get.offAll(LoginScreen());
    //pageController.jumpToPage(2);
  }
}