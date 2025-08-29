import 'package:flutter/material.dart';
import 'package:nishant_store/features/shop/screens/store/t_circular_image.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../models/product_model.dart';
import '../Home/t_brand_title_with_verification_icon.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, this.onTap, this.showBoarder = false, required this.brand,
  });

  final void Function()? onTap;
  final bool showBoarder;
  final Brands brand;

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            border: showBoarder ? Border.all(color: Colors.grey.withOpacity(0.3)) : null
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: true,
                  image: brand.image ?? "",
                  backgroundColor: Colors.transparent,
                  overlayColor: dark ? Colors.white : Colors.black
              ),
            ),

            SizedBox(width: 8),
            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerificationIcon(title: brand.name ?? "",isBold: true,),
                  Text(
                    '${brand.productCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}