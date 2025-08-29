import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/card/t_card.dart';

class TCardCounterIcon extends StatelessWidget {
  const TCardCounterIcon({
    super.key, required this.iconColor,
  });

  final Color iconColor;

  @override
  Widget build(BuildContext context) {

    final cartController = Get.put(CartController());

    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => TCard()), icon: Icon(Iconsax.shopping_bag, color: iconColor,)),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Obx(() => Text(cartController.noOfCartItem.value.toString(),style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white, fontSizeFactor: 0.8),)),
              ),
            )
        )
      ],
    );
  }
}
