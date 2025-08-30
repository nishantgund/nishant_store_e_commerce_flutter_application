import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

class SearchProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var query = "".obs; // reactive query string
  RxList<ProductModel> products = <ProductModel>[].obs;
  var isLoading = false.obs;

  /// Update the query whenever user types
  void updateQuery(String value) {
    query.value = value.trim();
    _searchProducts();
  }

  /// Firestore search logic
  void _searchProducts() {
    try{
      if (query.isEmpty) {
        products.clear();
        return;
      }

      isLoading.value = true;

      try{
        _firestore
            .collection('products')
            .where('Title', isGreaterThanOrEqualTo: query.value)
            .where('Title', isLessThanOrEqualTo: query.value + '\uf8ff')
            .snapshots()
            .listen((snapshot) {
          products.value = snapshot.docs.map((product) => ProductModel.fromJson(product.data())).toList();
        });
      }
      catch(e){
        throw Loaders.errorSnackBar(title: "Ohh Snap", message: e.toString());
      }

    }
    catch(e){
      throw Loaders.errorSnackBar(title: "Ohh Snap", message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }
}
