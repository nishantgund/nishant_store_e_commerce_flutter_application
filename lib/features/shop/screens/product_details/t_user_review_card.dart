import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';


class TUserReviewCard extends StatelessWidget {
  const TUserReviewCard({
    super.key,
    required this.userReview,
    required this.companyReview,
  });

  final String userReview, companyReview;


  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage1),),
                SizedBox(width: 16,),
                Text('Gauri Patil', style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
          ],
        ),
        SizedBox(height: 8,),

        // Review
        Row(
          children: [
            RatingBarIndicator( rating: 4.5, itemBuilder: (context,index) => Icon(Iconsax.star1,color: ColorsData.blue), unratedColor: Colors.grey, itemSize: 20,),
            SizedBox(width: 8,),
            Text('01 Mar, 2025', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: 16,),

        ReadMoreText(
          userReview,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
        ),
        SizedBox(height: 16,),

        // Company Review
        Container(
          margin: EdgeInsetsGeometry.only(left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: dark ? Colors.grey.withOpacity(0.3) : Colors.grey.withOpacity(0.4)
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nishant Store', style: Theme.of(context).textTheme.titleMedium,),
                    Text('11 May, 2025', style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
                SizedBox(height: 16,),

                ReadMoreText(
                  companyReview,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsData.blue),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 32)
      ],
    );
  }
}