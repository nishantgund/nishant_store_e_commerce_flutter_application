import 'package:get/get.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/images_controller.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';

class VariationController extends GetxController{
  static VariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = "".obs;
  Rx<PVOne> selectedVariation = PVOne.empty().obs;
  RxString price = "".obs;
  RxString salePrice = "".obs;

  void onSelect(ProductModel product, attributeName, attributeValue){

    // when attribute selected we will first add that attribute to selected Attributes
    final selectedAttribute2 = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttribute2[attributeName] = attributeValue;

    // show selected Attributes like ['Color', 'Size']
    this.selectedAttributes[attributeName] = attributeValue;

    // return selected variation

    final allVariations = [
      product.productsVariation!.one,
      product.productsVariation!.two,
      product.productsVariation!.three,
    ].where((v) => v != null).toList();

    final selectedVariation = allVariations.firstWhere(
          (variation) {
            final attr = variation!.attributeValue;
            if (attr == null) return false;

            // check only the attributes the user has selected so far
            return selectedAttributes.entries.every((entry) {
              final key = entry.key;
              final value = entry.value;

              if (key == "Color") return attr.color == value;
              if (key == "Size") return attr.size == value;

              return true; // ignore unknown attrs
            });
            },
      orElse: () => PVOne.empty(),
    );


    // show the selected variation Image as Main Image
    if(selectedVariation!.image!.isNotEmpty){
      ImagesController.instance.selectedProductImage.value = selectedVariation.image!;
    }

    // show selected variation quantity already in cart
    if(selectedVariation.id!.isNotEmpty){
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.productId!, selectedVariation.id!);
    }

    // Assign selected Variation
    this.selectedVariation.value = selectedVariation;
    this.salePrice.value = selectedVariation.salePrice.toString();
    this.price.value = selectedVariation.price.toString();


    // Update selected variation Stock Status
    getProductVariationStockStatus(selectedVariation);

  }

  // check Attributes availability / stock in variation
  Set<String?> getAttributesAvailabilityInVariation(List<PVOne> variations, String attributeName){
    // Post the variation to check which attribute re available to stock is not 0
    final availableVariationAttributeValue = variations
        .where((variation) =>
            variation.attributeValue != null &&
                (attributeName == "Color"
                    ? variation.attributeValue!.color?.isNotEmpty == true
                    : variation.attributeValue!.size?.isNotEmpty == true) &&
                (variation.stock ?? 0) > 0)
        .map((variation) =>
            attributeName == "Color"
                ? variation.attributeValue!.color
                : variation.attributeValue!.size)
        .toSet();

    return availableVariationAttributeValue;
  }

  // check product variation stock status
  String getProductVariationStockStatus(PVOne variation) {
    return variationStockStatus.value = variation.stock! > 0 ? 'In Stock' : 'Out of Stock';
  }

  // reset selected attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value = "";
    selectedVariation.value = PVOne.empty();
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice! > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }


  /// ----- Time Pass
  // select Attributes and Variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    // when attribute selected we will first add that attribute to selected Attributes
    final selectedAttribute2 = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttribute2[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

  }

  // check selected attributes match with any variation attributes
  bool isSameAttributesValue(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){

    // if selected Attributes content 3 attributes and current variation content 2 attributes
    if(variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attributes is different then return. ['Green', 'Large'] x ['Green', 'Small']
    for(final key in variationAttributes.keys){
      // Attributes[key] = value which could be ['Green', 'Small', 'Cotton'] etc.
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

}