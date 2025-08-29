import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Product/product_repository.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

import '../../../../data/repositories/Brands/brands_repository.dart';
import '../../models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  RxBool isLoading = false.obs;
  final RxList<Brands> allBrands = <Brands>[].obs;
  final RxList<Brands> featuredBrand = <Brands>[].obs;
  final brandRepository = Get.put(BrandsRepository());

  void onInit(){
    super.onInit();
    getFeaturedBrands();
  }

  // Load Brands
  Future<void> getFeaturedBrands() async {
    try{
      // start Loading
      isLoading.value = true;

      final List<Brands> brands =await brandRepository.getAllBrands();
      
      allBrands.assignAll(brands);
      
      featuredBrand.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    }
    catch (e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }


  // Get Brand for Category
  Future<List<Brands>> getBrandForCategory(String categoryId) async {
    try{
      final brand = await brandRepository.getBrandForCategory(categoryId);
      return brand;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  // Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try{
      final product = ProductRepository.instance.getProductForBrand(brandId: brandId, limit: limit);
      return product;
    }
    catch(e){
      throw Loaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

}