import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_settings.dart';
import 'package:nishant_store/features/shop/screens/Home/home_Screen.dart';
import 'package:nishant_store/features/shop/screens/store/TStoreScreen.dart';
import 'package:nishant_store/features/shop/screens/wishlist/t_wishlist.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

class TNavigationMenuScreen extends StatelessWidget {
  const TNavigationMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuController());
    final dark = THelperFunction.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: dark ? Colors.black : Colors.white,
            indicatorColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
        
            destinations: [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
              NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ]
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}


class NavigationMenuController extends GetxController{

  final Rx<int> selectedIndex = 0.obs;
  final screen = [THomeScreen(), TStoreScreen(), TWishlist(), TSettings()];

}
