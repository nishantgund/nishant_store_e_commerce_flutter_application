import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Product/product_repository.dart';
import 'package:nishant_store/data/repositories/categories/category_repository.dart';
import 'package:nishant_store/features/shop/models/category_model.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureAllCategories = <CategoryModel>[].obs;

  void onInit(){
    super.onInit();
    fetchCategories();
  }

  // Load Category data
  Future<void> fetchCategories() async{
    try{

      // show Loader while loading categories
      isLoading.value = true;

      // fetch category from data store
      final categories = await CategoryRepository.instance.getAllCategories();

      // update the category list
      allCategories.assignAll(categories);

      // filter future categories
      featureAllCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).toList());
      
    }
    catch(e){
      Loaders.errorSnackBar(title: 'OH Snap', message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

  // Load Selected Category data
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try{
      // Fetch sub category
      final subCategory = await categoryRepository.getSubCategories(categoryId);
      return subCategory;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  // Get Category & Sub-Category Products
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try{
      // get all category products
      final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

}