import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/shop/controllers/product/product_controller.dart';
import 'package:nishant_store/features/shop/screens/Favourite%20Icon/favourite_icon.dart';
import 'package:nishant_store/features/shop/screens/Home/t_brand_title_with_verification_icon.dart';
import 'package:nishant_store/features/shop/screens/Home/t_rounded_image.dart';
import 'package:nishant_store/features/shop/screens/product_details/product_details.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../models/product_model.dart';
import '../product_details/add_to_cart_button.dart';

class TProductCardVertical extends StatelessWidget {
  TProductCardVertical({super.key, required this.product});

  final ProductModel product ;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    var dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => TProductDetails(product: product)),
      child: Container(
          width: 180,
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
          child: Column(
            children: [
              Container(
                height: 180,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: dark ? Colors.grey : Colors.white
                ),
                child: Stack(
                  children: [
                    // Product Image
                    TRoundImage(imageUrl: product.image!,applyImageRadius: true,backgroundColor: dark ? Colors.grey : Colors.white,isNetworkImage: true,width: 180,height: 180,),

                    // Sales Tag
                    Positioned(
                      top: 8,
                      left: 8,
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
                        top: -4,
                        right: -4,
                        child: TFavouriteIcon(productId: product.productId!)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),

              // Product Details
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8,),

                    TBrandTitleWithVerificationIcon(title: product.brands!.name!,),
                    SizedBox(height: 4,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$' +product.salePrice.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Add To Card
                        ProductCartAddToCartButton(product: product,)
                      ],
                    )
                  ],
                )
              )
            ],
          ),
      ),
    );
  }
}



