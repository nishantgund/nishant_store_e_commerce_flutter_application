import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/common/widgets/brand_shimmer.dart';
import 'package:nishant_store/features/shop/controllers/category_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/brand_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/TCardMenuIcon.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/Home/search_container.dart';
import 'package:nishant_store/features/shop/screens/brands/t_all_brands.dart';
import 'package:nishant_store/features/shop/screens/brands/t_brand_products.dart';
import 'package:nishant_store/features/shop/screens/store/t_brand_card.dart';
import 'package:nishant_store/features/shop/screens/store/t_category_tab.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';

class TStoreScreen extends StatelessWidget {
  const TStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final categories = CategoryController.instance.featureAllCategories;
    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //backgroundColor: Colors.red,
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TCardCounterIcon(iconColor: dark ? Colors.white : Colors.black),
            )
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_,innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: dark ? Colors.black : Colors.white,
              expandedHeight: 400,
              flexibleSpace: Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // Search Bar
                    SizedBox(height: 16,),
                    TSearchContainer(text: 'Search in Store',showBoarder: true, showBackground: true, padding: EdgeInsets.zero,),
                    SizedBox(height: 32,),

                    // Feature Brand
                    TSectionHeading(title: 'Featured Brands', showActionBar: true, onPressed: () => Get.to(() => TAllBrands()),),
                    SizedBox(height: 16,),

                    Obx(
                        () {
                          if(brandController.isLoading.value) return BrandShimmer();

                          if(brandController.featuredBrand.isEmpty) {
                            return Center(child: Text("No Data Found",style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
                          }

                          return TGridLayout(
                            itemCount: brandController.featuredBrand.length,
                            mainAxisExtend: 80,
                            itemBuilder: (context, index) {
                              final brand = brandController.featuredBrand[index];
                              return TBrandCard(brand: brand,onTap: () => Get.to(() => TBrandProducts(brand: brand)),);
                            }
                          );
                        }
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                //controller: ,
                tabs: categories.map((category) => Tab(child: Text(category.name),)).toList(),
                isScrollable: true,
                indicatorColor: ColorsData.blue,
                labelColor: dark ? Colors.white : ColorsData.blue,
                unselectedLabelColor: Colors.grey,
                tabAlignment: TabAlignment.start,
              ),
            )
          ];
        },
            body: TabBarView(children: categories.map((category) => TCategoryTab(category: category)).toList())
        ),
      ),
    );
  }
}


// class TStoreAppBar extends StatelessWidget {
//   const TStoreAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var dark = THelperFunction.isDarkMode(context);
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//       child: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,),
//         actions: [
//           TCardCounterIcon(iconColor: dark ? Colors.white : Colors.black, onPressed: (){})
//         ],
//       ),
//     );
//   }
// }

