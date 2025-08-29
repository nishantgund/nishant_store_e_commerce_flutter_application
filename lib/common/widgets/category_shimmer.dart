import 'package:flutter/material.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 6
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_,_) => SizedBox(width: 16,),
        itemCount: itemCount,
        itemBuilder:(_,_){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              TShimmerEffects(width: 55, height: 55, radius: 55,),
              SizedBox(height: 8,),

              // Text
              TShimmerEffects(width: 55, height: 8)
            ],
          );
        },
      )
    );
  }
}
