import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/common/widgets/vertical_product_shimmer_effect.dart';
import 'package:nishant_store/features/shop/controllers/product/favourite_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/grid_layout.dart';
import 'package:nishant_store/features/shop/screens/Home/product_card_vertical.dart';
import 'package:nishant_store/utils/popups/animation_loader.dart';

import '../../../../navigation_menu.dart';

class TWishlist extends StatelessWidget {
  const TWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          //TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(THomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Obx(
              () => FutureBuilder(
              future: controller.favouriteProducts(),
              builder: (context, asyncSnapshot) {

                final Widget emptyWidget = TAnimationLoader(
                  text: 'Whoops! Wishlist is empty..',
                  animation: 'assets/images/animation/empty.json',
                  padding: EdgeInsets.only(top: 70),
                  showAction: true,
                  actionText: 'Add Some Products',
                  onActionPressed: () => Get.offAll(() => TNavigationMenuScreen()),
                );

                const loader = VerticalProductShimmerEffect();

                if(asyncSnapshot.connectionState == ConnectionState.waiting){
                  return loader;
                }

                if(!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty){
                  return emptyWidget;
                }

                if(asyncSnapshot.hasError){
                  return Center(child: Text('Something went Wrong'),);
                }

                final products = asyncSnapshot.data!;

                return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) => TProductCardVertical(product: products[index],));
              }
            ),
          )
        ),
      ),
    );
  }
}
