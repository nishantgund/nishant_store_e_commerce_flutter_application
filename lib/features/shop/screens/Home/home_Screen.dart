import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/common/widgets/vertical_product_shimmer_effect.dart';
import 'package:nishant_store/features/personalization/controllers/user_controller.dart';
import 'package:nishant_store/features/shop/controllers/category_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/product_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/product_card_vertical.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/Home/search_container.dart';
import 'package:nishant_store/features/shop/screens/Home/t_live_search_product.dart';
import 'package:nishant_store/features/shop/screens/Home/t_promo_slider.dart';
import 'package:nishant_store/features/shop/screens/Home/vertical_image_text.dart';
import 'package:nishant_store/features/shop/screens/all%20product/t_all_product.dart';
import 'package:nishant_store/features/shop/screens/sub%20category/t_sub_category.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/category_shimmer.dart';
import 'TCardMenuIcon.dart';
import 'grid_layout.dart';

class THomeScreen extends StatelessWidget {
  const THomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [

                    // Hedar Container
                    Container(
                      height: 380,
                      color: Color(0xFF4b68ff).withOpacity(0.9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App Bar
                          THomeAppBar(),
                          SizedBox(height: 32,),

                          // Search
                          TSearchContainer(text: 'Search in Store',onPressed: () => Get.to(() => TSearchScreen()),),
                          SizedBox(height: 32,),

                          // Categories
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Column(
                              children: [
                                // Headline
                                TSectionHeading(title: 'Popular Categories', showActionBar: false, textColor: Colors.white,),
                                SizedBox(height: 16,),

                                // Categories
                                THomeCategories(),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // Curve Design
                    Positioned(
                      top: 360,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: dark ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(30, 15),
                              topLeft: Radius.elliptical(30, 15)
                          ), // Rounded corners
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Promo Slider
              Padding(
                padding: const EdgeInsets.all(16),
                child: TPromoSlider()
              ),
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: TSectionHeading(
                  title: 'Popular Product',
                  onPressed: () =>
                      Get.to(() => TAllProduct(
                        title: 'Popular Product',
                        featureMethod: controller.fetchAllFeaturedProduct(),
                      )
                  )
                ),
              ),


              // Best Selling product
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  // Shimmer Effect
                  if(controller.isLoading.value) return VerticalProductShimmerEffect();

                  // data Not found
                  if(controller.featuredProduct.isEmpty) return Center(child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium,),);

                  return TGridLayout(
                    itemCount: controller.featuredProduct.length,
                    itemBuilder: (context, index) => TProductCardVertical(product: controller.featuredProduct[index]),
                  );
                })
              )
            ],
          ), //
      )
    );
  }
}

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if(categoryController.isLoading.value){
        return TCategoryShimmer();
      }

      if(categoryController.featureAllCategories.isEmpty){
        return Center(child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featureAllCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = categoryController.featureAllCategories[index];
              return TVerticalImageText(
                image: category.image,
                title: category.name,
                onPressed: () => Get.to(() => TSubCategory(category: category,)),
              );
            }
        ),
      );
    }
    );
  }
}


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key, 
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good day for shopping',style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white70),overflow: TextOverflow.ellipsis,maxLines: 1,),
                  Obx(() {
                    if(controller.profileLoading.value){
                      // Display the Shimmer Effect while fetching data from data Storage
                      return TShimmerEffects(width: 80, height: 15);
                    }
                    else{
                      return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white), overflow: TextOverflow.ellipsis,maxLines: 1,);
                    }
                  })
                ],
          ),
          actions: [
            TCardCounterIcon(iconColor: Colors.white,),
          ],
        ),
    );
  }
}

