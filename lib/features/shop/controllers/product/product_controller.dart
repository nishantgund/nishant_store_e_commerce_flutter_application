import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Product/product_repository.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProduct = <ProductModel>[].obs;

  void onInit() {
    super.onInit();
    fetchFeaturedProduct();
  }

  // fetch Limited Featured products
  void fetchFeaturedProduct() async {
    try {
      // Show Loader
      isLoading.value = true;

      // Fetch Product
      final product = await productRepository.getFeaturedProducts();

      // Assign Product
      featuredProduct.assignAll(product);
    }
    catch (e) {
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }

  // fetch All Featured products
  Future<List<ProductModel>> fetchAllFeaturedProduct() async {
    try {
      // Fetch Product
      final product = await productRepository.getAllFeaturedProducts();
      return product;
    }
    catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  // Calculate the discount
  String calculateDiscount(ProductModel product) {
    if (product.price != null && product.salePrice != null &&
        product.price! > 0) {
      int price = product.price!;
      int salePrice = product.salePrice!;
      double discountPercent = ((price - salePrice) / price) * 100;
      return "${discountPercent.toStringAsFixed(0)}%";
    }
    else {
      return "";
    }
  }

  // return products stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // return One Model all all Attributes
  List <One> getAttributes(ProductModel product) {
    One first = One(name: product.productsAttributes?.one?.name, values: product.productsAttributes?.one?.values);
    One second = One(name: product.productsAttributes?.two?.name, values: product.productsAttributes?.two?.values);
    return [first, second];
  }

  // return all values of given attributes
  List<String> getValues(Values values){
    String s2 = values.s2!;
    String one  = values.one!;
    String two = values.two!;
    return[s2, one, two];
  }

}