import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Product/product_repository.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

import '../models/product_model.dart';

class AllProductController extends GetxController{
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = "Brand".obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try{
      if(query == null) return [];

      final product = await repository.fetchProductByQuery(query);
      return product;
    }
    catch (e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  void sortProduct(String sortOption){
    selectedSortOption.value = sortOption;

    switch(sortOption){
      case "Brand":
        products.sort((a,b) => a.brands!.name!.compareTo(b.brands!.name!));
        break;

      case 'Higher Price':
        products.sort((a, b) => b.price!.compareTo(a.price!));
        break;

      case 'Lower Price':
        products.sort((a,b) => a.price!.compareTo(b.price!));
        break;

      case 'Sale':
        products.sort((a,b) {
          if(b.salePrice! > 0){
            return b.salePrice!.compareTo(a.salePrice!);
          }
          else if(a.salePrice! > 0){
            return -1;
          }
          else{
            return 1;
          }
        });
        break;

      default: products.sort((a, b) => a.title!.compareTo(b.title!));
    }
  }

  void assignProducts(List<ProductModel> product){
    this.products.assignAll(product);
    sortProduct("Brand");
  }

}