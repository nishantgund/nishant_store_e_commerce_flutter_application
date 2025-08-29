import 'package:flutter/material.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        mainAxisExtend: 80,
        itemCount: itemCount,
        itemBuilder: (_,_) => TShimmerEffects(width: 300, height: 80));
  }
}
