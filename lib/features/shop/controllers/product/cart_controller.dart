import 'package:get/get.dart';
import 'package:nishant_store/features/shop/controllers/product/variation_controller.dart';
import 'package:nishant_store/features/shop/models/cart_item_model.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/utils/local_storage/storage_utility.dart';
import 'package:nishant_store/utils/popups/loaders.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();


  // variable
  RxInt noOfCartItem = 0.obs;
  RxInt totalCartPrice = 0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItem();
  }

  void addToCart (ProductModel product){
    // Quantity check
    if(productQuantityInCart.value < 1){
      Loaders.warningSnackBar(title: 'Select Quantity');
      return;
    }

    // variation Select
    if(!product.productsVariation.isBlank! && variationController.selectedVariation.value.id!.isEmpty){
      Loaders.warningSnackBar(title: 'Select Variation');
      return;
    }


    // out of stock Status
    if(product.productsVariation.isBlank!){
      if(product.stock! < 1){
        Loaders.warningSnackBar(title: 'Oh Snap', message: 'Selected Product is Out of Stock');
        return;
      }
    }
    else{
      if(variationController.selectedVariation.value.stock! < 1){
        Loaders.warningSnackBar(title: 'Oh Snap', message: 'Selected Variation is Out of Stock');
        return;
      }
    }

    // Convert the ProductModel to CartItemModel with the given quantity
    final selectedCartItem = covertToCartItem(product, productQuantityInCart.value);

    // check if already added in the cart
    int index = cartItems.indexWhere((cartItems) => cartItems.productId == selectedCartItem.productId && cartItems.variationId == selectedCartItem.variationId);

    if(index >= 0){
      // this quantity is already added or updated/remove from the design (Cart)(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    }
    else{
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.successSnackBar(title: 'Your Product has been added to the Cart');

  }

  // the function Convert ProductModel to CartItemModel
  CartItemModel covertToCartItem(ProductModel product, int quantity){

    if(product.productsVariation.isBlank!){
      // Reset variation in case single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id!.isNotEmpty;
    final Map<String, String> selectedAttributes = {"${variation.attributeValue!.color}":"${variation.attributeValue!.size}"};
    final price = isVariation
        ? variation.salePrice! > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice! > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
        title: product.title!,
        price: price!,
        productId: product.productId!,
        variationId: variation.id!,
        image: isVariation ? variation.image : product.image,
        brandName: product.brands!.name,
        selectedVariation: isVariation ? selectedAttributes : {"":""},
        quantity: quantity,
    );
  }

  // Update Cart values
  void updateCart(){
    updateCartTotals();
    saveCartItem();
    cartItems.refresh();
  }

  void updateCartTotals(){
    int calculatedTotalPrice = 0;
    int calculatedNumberOfItem = 0;

    for(var item in cartItems){
      calculatedTotalPrice += (item.price) * item.quantity;
      calculatedNumberOfItem += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItem.value = calculatedNumberOfItem;
  }

  void saveCartItem(){
    final cartItemString = cartItems.map((item) => item.toJSON()).toList();
    TLocalStorage.instance().saveData("CartItem", cartItemString);
  }

  void loadCartItem(){
    final cartItemString = TLocalStorage.instance().readData<List<dynamic>>('CartItem');
    if(cartItemString != null){
      cartItems.assignAll(cartItemString.map((item) => CartItemModel.fromJSON(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId){
    final foundItem = cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId){
    final foundItem = cartItems.firstWhere((item) => item.productId == productId && item.variationId == variationId, orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartitem) => cartitem.productId == item.productId && cartitem.variationId == item.variationId);

    if(index >= 0){
      cartItems[index].quantity += 1;
    }
    else{
      cartItems.add(item);
    }

    updateCart();
  }


  void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere((cartitem) => cartitem.productId == item.productId && cartitem.variationId == item.variationId);

    if(index >= 0){
      if(cartItems[index].quantity > 1){
        cartItems[index].quantity -= 1;
      }
      else{
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }

  }

  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: "Remove Product",
      middleText: 'Are you sure, you want to remove this product?',
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        Loaders.successSnackBar(title: 'Product remove from Cart.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateAlreadyAddProductCount(ProductModel product){
    // if product has no variation than calculate cartEntries nd display total number
    // else make default entries to 0 and show cartEntries when variation s selected
    if(!product.productsVariation.isBlank!){
      productQuantityInCart.value = getProductQuantityInCart(product.productId!);
    }
    else{
      // get selected variation if any
      final variationId = variationController.selectedVariation.value.id!;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.productId!, variationId);
      }
      else{
        productQuantityInCart.value = 0;
      }
    }
  }


}