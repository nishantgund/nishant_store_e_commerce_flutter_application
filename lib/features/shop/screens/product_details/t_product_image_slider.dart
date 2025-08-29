import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/shop/controllers/product/images_controller.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/product_model.dart';
import '../Favourite Icon/favourite_icon.dart';
import '../Home/t_rounded_image.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.product,
  });

  final ProductModel product;


  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProducts(product);
    return Stack(
      children: [
        Container(
            color: dark ? Colors.grey : Colors.grey.withOpacity(0.2),
            width: double.infinity,
            child: Stack(
              children: [
                // Main Large Image
                SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Obx(() {
                        final image = controller.selectedProductImage.value;
                        return Image(image: NetworkImage(image));
                      })
                    ),
                ),

                // Image slider
                Positioned(
                  right: 16,
                  bottom: 30,
                  left: 16,
                  child: SizedBox(
                    height: 85,
                    child: ListView.separated(
                      separatorBuilder: (_,__) => SizedBox(width: 16,),
                      itemCount: images.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          Obx(()
                          {
                            final imageSelected = controller.selectedProductImage.value == images[index];
                            return TRoundImage(
                            width: 90,
                            backgroundColor: dark ? Colors.black : Colors.white,
                            border: Border.all(color: imageSelected ? Colors.blue : Colors.transparent),
                            padding: EdgeInsets.all(8),
                            imageUrl: images[index],
                            isNetworkImage: true,
                              onPressed: () => controller.selectedProductImage.value = images[index],
                            );
                          }
                          ),
                    ),
                  ),
                ),

                // AppBar Icons
                AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TFavouriteIcon(productId: product.productId!, iconSize: 32,),
                    )
                  ],
                )

              ],
            )
        ),

        // Design
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 15,
            decoration: BoxDecoration(
              color: dark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(30, 15),
                  topLeft: Radius.elliptical(30, 15)
              ), // Rounded corners
            ),
          ),
        )
      ],
    );
  }
}