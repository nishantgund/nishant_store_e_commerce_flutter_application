import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/common/widgets/vertical_product_shimmer_effect.dart';
import 'package:nishant_store/features/shop/controllers/product/product_controller.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';
import 'package:nishant_store/features/shop/screens/Home/product_card_vertical.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/all%20product/t_all_product.dart';
import 'package:nishant_store/features/shop/screens/store/t_category_brand.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';


class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              // Brands
              TCategoryBrands(category: category),

              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, asyncSnapshot) {

                  const loader = Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TShimmerEffects(width: 130, height: 20),
                          TShimmerEffects(width: 50, height: 20),
                        ],
                      ),

                      // Products
                      SizedBox(height: 32,),
                      Center(child: VerticalProductShimmerEffect()),
                    ],
                  );

                  if(asyncSnapshot.connectionState == ConnectionState.waiting){
                    return loader;
                  }

                  if(!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty){
                    return Center(child: Text('No Data Found!'),);
                  }

                  if(asyncSnapshot.hasError){
                    return Center(child: Text('Something went Wrong'),);
                  }

                  final products = asyncSnapshot.data!;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TSectionHeading(
                            showActionBar: true,
                            title: 'You might like',
                            onPressed: () => Get.to(() => TAllProduct(
                              title: category.name,
                              featureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                            ))
                        ),
                      ),
                      SizedBox(height: 16,),

                      // Product Grid Layout
                      TGridLayout(itemCount: products.length, itemBuilder: (context, index) => TProductCardVertical(product: products[index],)),
                      SizedBox(height: 8,)
                    ],
                  );
                }
              ),

            ],
          ),
        ),
      ]
    );
  }
}