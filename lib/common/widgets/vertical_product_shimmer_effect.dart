import 'package:flutter/material.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';
class VerticalProductShimmerEffect extends StatelessWidget {
  const VerticalProductShimmerEffect({super.key, this.itemCount = 6, });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return TGridLayout(itemCount: itemCount, itemBuilder: (_,_) => SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          TShimmerEffects(width: 180, height: 180),
          SizedBox(height: 16,),

          // Text
          TShimmerEffects(width: 160, height: 15),
          SizedBox(height: 8,),
          TShimmerEffects(width: 110, height: 15),

        ],
      ),
    ));
  }
}
