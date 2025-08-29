import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/product_details/product_details.dart';
import '../../../../utils/constants/colors.dart';
import '../../models/product_model.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return InkWell(
      onTap: () {
        // if the product has variation show the product details for variation selection
        if(product.productsVariation.isBlank!){
          final cartItem = cartController.covertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        }
        else{
          Get.to(() => TProductDetails(product: product));
        }

      },
      child: Obx(
          () {
            final productQuantityInCart = cartController.getProductQuantityInCart(product.productId!);
            return Container(
            decoration: BoxDecoration(
                color: productQuantityInCart > 0 ? ColorsData.blue : Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(16.0)
                )
            ),
              child: SizedBox(
                width: 28*1.5,
                height: 28*1.5,
                child: Center(
                  child: productQuantityInCart > 0
                      ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.white),)
                      : Icon(Iconsax.add, color: Colors.white,)
                ),
              ),
            );
          }
      ),
    );
  }
}