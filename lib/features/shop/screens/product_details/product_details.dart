import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_checkout_screen.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_bottom_add_to_card.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_product_attributes.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_product_image_slider.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_product_meta_data.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_product_review.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_rating_&_share.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constants/colors.dart';
import '../../models/product_model.dart';

class TProductDetails extends StatelessWidget {
  const TProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: TBottomAddToCard(product: product,),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Header
            TProductImageSlider(product: product),

            // Product Details
            Padding(
              padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 8),
              child: Column(
                children: [

                  // Rating and Share Button
                  TRatingAndShare(),

                  // Price, Title, Stack & Brand
                  TProductMetaData(product: product),

                  // Attributes
                  TProductAttributes(product: product,),
                  SizedBox(height: 32,),

                  // Checkout Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => TCheckoutScreen()), child: Text('Check Out'))),
                  SizedBox(height: 32,),

                  // Description
                  TSectionHeading(title: 'Description', showActionBar: false,),
                  SizedBox(height: 16,),
                  ReadMoreText(
                    product.description! ?? "",
                    trimLines: 1,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show Less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
                  ),
                  SizedBox(height: 8,),

                  // Reviews
                  Divider(),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(title: 'Reviews (109)', onPressed: (){},showActionBar: false,),
                      IconButton(onPressed: () => Get.to(() => TProductReview()), icon: Icon(Iconsax.arrow_right_3,size: 18,))
                    ],
                  ),

                  SizedBox(height: 16,)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



