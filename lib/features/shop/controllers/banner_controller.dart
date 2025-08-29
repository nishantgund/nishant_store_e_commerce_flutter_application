import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/Banners/banner_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final categoryRepository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;

  void onInit(){
    super.onInit();
    fetchBanner();
  }

  // Update the Page navigation Bar
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  // Fetch Banner
  Future<void> fetchBanner() async{
    try{
      // show Loader while loading categories
      isLoading.value = true;

      // fetch category from data store
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.getAllBanners();

      // Assign Banner
      this.banners.assignAll(banners);

    }
    catch(e){
      Loaders.errorSnackBar(title: 'OH Snap', message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

}