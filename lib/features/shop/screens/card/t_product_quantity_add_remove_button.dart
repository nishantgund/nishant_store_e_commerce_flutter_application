import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/models/cart_item_model.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../Home/t_circular_icon.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: 16,
          color: dark ? Colors.white : Colors.black,
          backgroundColor: dark ? Colors.grey.withOpacity(0.3) : Colors.white,
          onPressed:remove,
        ),
        SizedBox(width: 16,),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(width: 16,),

        TCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: 16,
          color: Colors.white,
          backgroundColor: ColorsData.blue,
          onPressed: add,
        ),
      ],
    );
  }
}