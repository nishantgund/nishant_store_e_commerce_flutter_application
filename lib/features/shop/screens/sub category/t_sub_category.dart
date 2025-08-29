import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/category_controller.dart';
import 'package:nishant_store/features/shop/models/category_model.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/Home/t_rounded_image.dart';
import 'package:nishant_store/features/shop/screens/all%20product/t_all_product.dart';
import 'package:nishant_store/features/shop/screens/sub%20category/t_product_card_horizontal.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/shimmer.dart';

class TSubCategory extends StatelessWidget {
  const TSubCategory({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final categoryController = CategoryController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text(category.name, style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Banner
              //TPromoSlider(),
              TRoundImage(imageUrl: TImages.promoBanner3, width: double.infinity, applyImageRadius: true,),
              SizedBox(height: 32,),

              // Sub category
              FutureBuilder<List<CategoryModel>>(
                future : categoryController.getSubCategory(category.id),
                builder: (context, asyncSnapshot) {

                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return TShimmerEffects(width: double.infinity, height: 200);
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Error: ${asyncSnapshot.error}"));
                  }

                  if (!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No Sub Category Found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  final subcategory = asyncSnapshot.data;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subcategory?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index){
                        final subCategory = subcategory![index];
                        return FutureBuilder(
                          future: categoryController.getCategoryProducts(categoryId: subCategory.id),
                          builder: (context, asyncSnapshot) {

                            // this will help me to show at least title of sub category
                            final products = asyncSnapshot.data ?? [];

                            // error show
                            if (asyncSnapshot.hasError) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TSectionHeading(title: subCategory.name, onPressed: () {}),
                                  const SizedBox(height: 8),
                                  Text("Error loading products"),
                                ],
                              );
                            }

                            return Column(
                              children: [
                                TSectionHeading(
                                  title: subCategory.name,
                                  onPressed: () => Get.to(
                                    () => TAllProduct(title: subCategory.name, featureMethod: categoryController.getCategoryProducts(categoryId: subCategory.id, limit: -1),)
                                  ),
                                ),
                                SizedBox(height: 8,),

                                products.isNotEmpty
                                    ? SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (_,_) => SizedBox(width: 16,),
                                          itemBuilder: (context, index) => TProductCardHorizontal(product: products[index],)
                                      ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          "No Products Found",
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ),
                              ],
                            );
                          }
                        );
                      }
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

