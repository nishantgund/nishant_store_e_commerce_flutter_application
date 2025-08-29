import 'package:flutter/material.dart';
import 'package:nishant_store/features/shop/models/cart_item_model.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../Home/t_brand_title_with_verification_icon.dart';
import '../Home/t_rounded_image.dart';

class TCardItem extends StatelessWidget {
  const TCardItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    return Row(
      children: [
        // Image
        TRoundImage(
          width: 65,
          height: 65,
          padding: EdgeInsets.all(4),
          isNetworkImage: true,
          imageUrl: cartItem.image ?? "",
          backgroundColor: dark ? Colors.grey.withOpacity(0.9) : Colors.white,
        ),
        SizedBox(width: 24,),

        // Title, Price, Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerificationIcon(title: cartItem.brandName ?? ""),
              Text(cartItem.title ?? "", style: Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis)),

              // Attributes
              Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {}).entries.map(
                              (e) => TextSpan(
                                  children: [
                                    TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(text: '${e.key} ', style: Theme.of(context).textTheme.bodyLarge),
                                    TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(text: '${e.value}', style: Theme.of(context).textTheme.bodyLarge),
                                  ],
                              ),
                      ).toList(),
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}