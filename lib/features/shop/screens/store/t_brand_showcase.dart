import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/features/shop/screens/brands/t_brand_products.dart';
import 'package:nishant_store/features/shop/screens/store/t_brand_card.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/brand_controller.dart';


class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  //final List<String> images;

  final Brands brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {

    return InkWell(
            onTap: () => Get.to(() => TBrandProducts(brand: brand)),
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey,
                  )
              ),
              child: Column(
                children: [
                  // Brand With Product Count
                  TBrandCard(brand: brand),

                  // Brand Tap 3 Product Image
                  Row(children: images.map((image) => brandTopProductImageWidget(image, context)).toList())
                ],
              ),
            ),
        );
  }

  Widget brandTopProductImageWidget(String image, context){
    var dark = THelperFunction.isDarkMode(context);
    return Expanded(
      child: Container(
        height : 100,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: dark ? Colors.grey : Colors.white,
        ),
        child: Image(image: NetworkImage(image)),
      ),
    );
  }
}