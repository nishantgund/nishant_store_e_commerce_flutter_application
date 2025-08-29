import 'dart:convert';

import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Product/product_repository.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/utils/local_storage/storage_utility.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

class FavouriteController extends GetxController{
  static FavouriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  void onInit(){
    super.onInit();
    initFavourite();
  }

  // fetch all favourite list from storage
  Future<void> initFavourite() async {
    // here readData return only value and value can be type of <key, value>
    final json = TLocalStorage.instance().readData('Favourites');
    if(json != null){
      final storedFavourite = jsonDecode(json) as Map<String, dynamic>;
      // Map the {Key, value} value JSON format to {Key, Bool} format
      favourites.assignAll(storedFavourite.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  // check the products is favourite or not
  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }

  // Add and Remove favourite from list
  void toggleFavouriteProduct(String productId){
    if(!favourites.containsKey(productId)){
      favourites[productId] = true;
      saveFavouritesToStorage();
      Loaders.successSnackBar(title: 'Products has been added to the Wishlist. ');
    }
    else{
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      Loaders.successSnackBar(title: 'Products has been remove from the Wishlist. ');
    }
  }

  // save the favourite list to local storage
  void saveFavouritesToStorage(){
    final encodedFavourite = json.encode(favourites);
    TLocalStorage.instance().saveData('Favourites', encodedFavourite);
  }

  //
  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }

}