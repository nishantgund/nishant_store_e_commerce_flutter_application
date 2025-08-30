import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/features/shop/controllers/product/search_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/product_card_vertical.dart';

import 'grid_layout.dart';

class TSearchScreen extends StatelessWidget {
  const TSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchProductController());

    return Scaffold(
      appBar: AppBar(title: const Text("Search Products"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => controller.updateQuery(value),
            ),
          ),

          // Reactive product list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return TGridLayout(
                itemCount: controller.products.length,
                itemBuilder: (context, index) => TProductCardVertical(product: controller.products[index]),
              );
            }),
          ),
        ],
      ),
    );
  }
}
