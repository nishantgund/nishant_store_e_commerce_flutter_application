import 'package:flutter/material.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/shop/controllers/product/brand_controller.dart';
import 'package:nishant_store/features/shop/models/category_model.dart';
import 'package:nishant_store/features/shop/screens/store/t_brand_showcase.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';

import '../../models/product_model.dart';

class TCategoryBrands extends StatelessWidget {
  const TCategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandForCategory(category.id),
      builder: (context, asyncSnapshot) {

        // Loader
        const loader = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32,),
            TShimmerEffects(width: 360, height: 190),
            SizedBox(height: 24,),
            TShimmerEffects(width: 360, height: 190),
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

        // brands found
        final brands = asyncSnapshot.data;

        return ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: brands!.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              //return TBrandShowcase(images: [TImages.productImage1,TImages.productImage1, TImages.productImage1], brand: brand);
              return FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id ?? "", limit: 3),
                builder: (context, asyncSnapshot) {

                  // Loader
                  const loader = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 32,),
                      TShimmerEffects(width: 360, height: 190),
                      SizedBox(height: 24,),
                      TShimmerEffects(width: 360, height: 190),
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

                  return TBrandShowcase(
                      images: products.map((e) => e.image!).toList(),
                      brand: brand
                  );
                }
              );
            }
        );
      }
    );
  }
}
