import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/t_circular_icon.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../models/product_model.dart';

class TBottomAddToCard extends StatelessWidget {
  const TBottomAddToCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final cartController = CartController.instance;
    cartController.updateAlreadyAddProductCount(product);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: dark ? Colors.grey.withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
                children: [
                  TCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: dark ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.6),
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    onPressed: () => cartController.productQuantityInCart.value < 1 ? null : cartController.productQuantityInCart.value -= 1,
                  ),
                  SizedBox(width: 16,),
                  Text(cartController.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(width: 16,),
                  TCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: Colors.black,
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    onPressed: () => cartController.productQuantityInCart.value += 1,
                  ),
                ],
             ),
            ElevatedButton(
                onPressed: cartController.productQuantityInCart.value < 1 ? null : () => cartController.addToCart(product),
                child: Text('Add to Card'),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.all(16)
                )
            )
          ],
        ),
      ),
    );
  }
}
