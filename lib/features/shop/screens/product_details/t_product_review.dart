import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_overall_product_rating.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_user_review_card.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class TProductReview extends StatelessWidget {
  TProductReview({super.key});

  String userReview = 'I’ve been using the Nike Air Jordan shoes for a few weeks now and they’re amazing. They’re super comfy, lightweight, and perfect for everyday wear. The design is sleek and turns heads wherever I go. Grip and fit are spot on — ideal for both casual outings and playing. Definitely one of the best sneakers I’ve owned!';
  String companyReview = 'Thanks for the great feedback! We’re glad to hear the Air Jordans are delivering comfort, style, and performance. It’s awesome that you’re enjoying them both on and off the court. Your satisfaction means everything to us. Keep rocking your Jordans with confidence!';

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Reviews & Ratings', style: Theme.of(context).textTheme.headlineMedium,),
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rating and reviews are verified and are from people who use the same type of product that you are use.'),
              SizedBox(height: 16,),

              // Overall Product Rating
              TOverallProductRating(),
              RatingBarIndicator( rating: 3.5, itemBuilder: (context,index) => Icon(Iconsax.star1,color: ColorsData.blue), unratedColor: Colors.grey, itemSize: 20,),
              Padding(padding: const EdgeInsets.only(top: 4,left: 4),
                child: Text('12,611', style: Theme.of(context).textTheme.bodySmall,),
              ),
              SizedBox(height: 32),

              // User Review List
              TUserReviewCard(userReview: userReview, companyReview: companyReview,),
              TUserReviewCard(userReview: userReview, companyReview: companyReview,),
              TUserReviewCard(userReview: userReview, companyReview: companyReview,),
            ],
          ),
        ),
      ),
    );
  }
}



