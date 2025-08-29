import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/brand_controller.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/brands/t_brand_products.dart';
import 'package:nishant_store/features/shop/screens/store/t_brand_card.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/brand_shimmer.dart';

class TAllBrands extends StatelessWidget {
  const TAllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Brand', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Headline
              TSectionHeading(title: 'Brands', showActionBar: false,),
              SizedBox(height: 32,),

              // Brands
              Obx(()
                {
                    if(brandController.isLoading.value) return BrandShimmer();

                    if(brandController.allBrands.isEmpty) {
                      return Center(child: Text("No Data Found",style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
                    }

                    return TGridLayout(
                        itemCount: brandController.allBrands.length,
                        mainAxisExtend: 80,
                        itemBuilder: (context, index) {
                          final brand = brandController.allBrands[index];
                          return TBrandCard(
                            brand: brand,
                            onTap: () => Get.to(() => TBrandProducts(brand: brand)),
                            showBoarder: true,
                          );
                        }
                    );
                }
              )
              //TGridLayout(mainAxisExtend: 80,itemCount: 10, itemBuilder: (context, index) => TBrandCard(showBoarder: true,onTap: () => Get.to(() => TBrandProducts()), brand: Brands.empty(),)),
            ],
          ),
        ),
      ),
    );
  }
}
