import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/all_product_controller.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';

import '../Home/grid_layout.dart';
import '../Home/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.product,
  });

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(product);
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            value: controller.selectedSortOption.value,
            onChanged: (values) => controller.sortProduct(values!.toString()),
            items: ['Brand','Higher Price', 'Lower Price', 'Sale'].
            map((option) => DropdownMenuItem(child: Text(option), value: option)).toList()
        ),
        SizedBox(height: 32,),

        // Product
        Obx(() => TGridLayout(itemCount: controller.products.length, itemBuilder: (context, index) => TProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}