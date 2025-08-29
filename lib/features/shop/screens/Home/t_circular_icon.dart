import 'package:flutter/material.dart';

import '../../../../utils/helpers/helper_functions.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = 24,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.borderColor = false,

  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;
  final bool borderColor;


  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor != null
              ? backgroundColor!
              : dark ? Colors.black.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        border: borderColor ? Border.all(color: dark ? Colors.grey : Colors.black) : null,
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color,size: size,),)
    );
  }
}