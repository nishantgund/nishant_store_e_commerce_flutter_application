import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/features/shop/screens/Home/t_brand_title_with_verification_icon.dart';
import 'package:nishant_store/features/shop/screens/Home/t_rounded_image.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/product/product_controller.dart';
import '../Favourite Icon/favourite_icon.dart';
import '../product_details/product_details.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    bool dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => TProductDetails(product: product)),
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 50,
              spreadRadius: 7,
              offset: Offset(0, 2)
          ),],
          borderRadius: BorderRadius.circular(16),
          color: dark ? Colors.black : Colors.white,
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              height: 120,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: dark ? Colors.grey : Colors.white
              ),
              child: Stack(
                children: [
                  // Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundImage(imageUrl: product.image!,isNetworkImage: true, applyImageRadius: true,backgroundColor: dark ? Colors.grey : Colors.white,),
                  ),

                  // sales tag
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.yellow.withOpacity(0.8),
                      ),
                      child: Text(controller.calculateDiscount(product), style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),),
                    ),
                  ),

                  // Favourite Icon Button
                  Positioned(
                    top: -8,
                    right: -4,
                    child: TFavouriteIcon(productId: product.productId!),
                  )
                ],
              ),
            ),
            SizedBox(width: 8,),

            // Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 5,),
                          Text(product.title!,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          TBrandTitleWithVerificationIcon(title: product.brands!.name!),
                        ],
                      ),
                      SizedBox(height: 4),

                      Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text('\$' + product.salePrice.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Add to Card
                          Container(
                              decoration: BoxDecoration(
                                  color: dark ? ColorsData.blue : Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      bottomRight: Radius.circular(16.0)
                                  )
                              ),
                              child: SizedBox(
                                  width: 32*1.2,
                                  height: 32*1.2,
                                  child: Center(child: Icon(Iconsax.add, color: Colors.white,))
                              )
                          ),
                        ],
                      )
                    ],
                  ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
