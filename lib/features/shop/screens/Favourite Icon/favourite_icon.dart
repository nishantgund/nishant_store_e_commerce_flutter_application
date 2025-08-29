import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/favourite_controller.dart';

import '../Home/t_circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId, this.iconSize = 24, });

  final String productId;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
            () {
              return TCircularIcon(
                icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
                color: controller.isFavourite(productId) ? Colors.red : null,
                backgroundColor: Colors.transparent,
                onPressed: () => controller.toggleFavouriteProduct(productId),
                size: iconSize,
              );
            }
    );
  }
}
