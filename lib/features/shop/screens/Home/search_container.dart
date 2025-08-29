import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/helper_functions.dart';


class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal ,
    this.showBackground = true,
    this.showBoarder = true,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });


  final String text;
  final IconData? icon;
  final bool showBackground, showBoarder;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: showBackground ? dark ? Colors.black : Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: showBoarder ? Border.all(color: Colors.white70) : null
          ),
          child: Row(
            children: [
              Icon(icon, color: dark ? Colors.white : Colors.black,),
              SizedBox(width: 16,),

              Text(text, style: Theme.of(context).textTheme.bodySmall,)
            ],
          ),
        ),
      ),
    );
  }
}