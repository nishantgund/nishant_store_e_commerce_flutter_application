import 'package:get/get.dart';

import '../../models/product_model.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = "".obs;

  List<String> getAllProducts(ProductModel product){

    // using set for adding only unique images
    Set<String> images = {};

    // Load Main Image
    images.add(product.image!);

    // Assign Main Images As Selected Image
    selectedProductImage.value = product.image!;

    // get all images from product variation if not null
    if(product.productsVariation != null){
      images.add(product.productsVariation!.one!.image!);
      images.add(product.productsVariation!.three!.image!);
      images.add(product.productsVariation!.two!.image!);
    }

    return images.toList();

  }


}