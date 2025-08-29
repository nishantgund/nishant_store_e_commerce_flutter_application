import 'package:flutter/material.dart';
import 'package:nishant_store/features/shop/controllers/product/product_controller.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/product_model.dart';
import '../Home/t_brand_title_with_verification_icon.dart';
import '../store/t_circular_image.dart';


class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price and Sale Price
        Row(
          children: [
            // Sale Tag
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.yellow.withOpacity(0.8),
              ),
              child: Text(controller.calculateDiscount(product), style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),),
            ),
            SizedBox(width: 8,),

            // Price
            Text('\$' +product.price.toString(), style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough,overflow: TextOverflow.ellipsis),),
            SizedBox(width: 16,),
            Text('\$' + product.salePrice.toString(),style: Theme.of(context).textTheme.headlineMedium!.apply(overflow: TextOverflow.ellipsis),)

          ],
        ),
        SizedBox(height: 16,),

        // Title
        Text(product.title ?? "", style: Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis),),
        SizedBox(height: 16,),

        // Stock Status
        Row(
          children: [
            Text('Status', style: Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis),),
            SizedBox(width: 16,),
            Text(controller.getProductStockStatus(product.stock!), style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
        SizedBox(height: 16,),

        // Brand
        Row(
          children: [
            TCircularImage(
              image: product.brands!.image ?? "",
              width: 42,
              height: 42,
              overlayColor: dark ? Colors.white : Colors.black,
              isNetworkImage: true,
            ),
            TBrandTitleWithVerificationIcon(title: product.brands!.name ?? "", isBold: true,),
          ],
        )

      ],
    );
  }
}