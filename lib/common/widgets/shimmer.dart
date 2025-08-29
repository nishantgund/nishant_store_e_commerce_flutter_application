import 'package:flutter/material.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class TShimmerEffects extends StatelessWidget{

  const TShimmerEffects({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color
  }) : super(key : key);

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor:dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? (dark ? Colors.grey : Colors.white)
        ),
      ),
    );
  }



}