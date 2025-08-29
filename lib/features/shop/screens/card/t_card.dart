import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/card/t_card_items.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_checkout_screen.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/popups/animation_loader.dart';


class TCard extends StatelessWidget {
  const TCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    bool dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: Obx(
          () {
            // Nothing found widget
            final emptyWidget= TAnimationLoader(
                text: 'Whoops Cart is Empty!',
                animation: 'assets/images/animation/empty.json',
            );

            return cartController.cartItems.isEmpty
            ? emptyWidget
            : SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.all(16),
              child: TCardItems(),
              ),);
          }
      ),
      bottomNavigationBar: cartController.cartItems.isEmpty
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 16,right: 16,left: 16,top: 8),
              child: ElevatedButton(onPressed: () => Get.to(() => TCheckoutScreen()), child: Obx(() => Text('Checkout \$${cartController.totalCartPrice.value}'))),
          ) ,
    );
  }
}




