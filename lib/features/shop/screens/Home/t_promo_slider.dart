import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/shop/screens/Home/t_rounded_image.dart';
import 'package:nishant_store/features/shop/screens/store/t_circular_image.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers/banner_controller.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(
        () {
          // shimmer effects
          if(controller.isLoading.value){
            return TShimmerEffects(width: double.infinity, height: 190);
          }

          // No data Found
          if(controller.banners.isEmpty){
            return Center(child: Text('No Data Found'));
          }

          else{
            return Column(
              children: [
                CarouselSlider(
                    items: controller.banners
                        .map(
                            (banner) => TRoundImage(
                            imageUrl: banner.imageUrl,
                            isNetworkImage: true,
                            onPressed: (){}
                        )
                    ).toList(),

                    options: CarouselOptions(
                        viewportFraction: 1,
                        onPageChanged: (index, _) => controller.updatePageIndicator(index)
                    )
                ),
                SizedBox(height: 16,),

                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i = 0; i < controller.banners.length; i++) Container(
                      width: 20,
                      height: 4,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: controller.carousalCurrentIndex == i ? ColorsData.blue : Colors.grey
                      ),
                    )
                  ],
                ),
                ),
              ],
            );
          }
        }
        );
  }
}