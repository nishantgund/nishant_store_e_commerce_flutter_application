import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_list_tile.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_profile_card.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_user_profile_tile.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/card/t_card.dart';
import 'package:nishant_store/features/shop/screens/order/t_order.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../address/t_user_address_screen.dart';

class TSettings extends StatelessWidget {
  const TSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Header
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  color: Color(0xFF4b68ff).withOpacity(0.9),
                  child: Column(
                    children: [
                      // AppBar
                      AppBar(
                        automaticallyImplyLeading: false,
                        title: Text('Account',style: Theme.of(context).textTheme.headlineMedium ),
                      ),
                      SizedBox(height: 16,),

                      // User Profile Card
                      TUserProfileTile(onPressed: () => Get.to(() => TProfileCard()),),

                    ],
                  ),
                ),
                Positioned(
                  top: 210,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: dark ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(30, 15),
                          topLeft: Radius.elliptical(30, 15)
                      ), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),

            // Body
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  // Account Settings
                  SizedBox(height: 16,),
                  TSectionHeading(title: 'Account Setting', showActionBar: false,),
                  SizedBox(height: 16,),

                  TListTile(icon: Iconsax.safe_home, title: 'My Address', subTitle: 'Set shopping delivery address',onTap: () => Get.to(() => TUserAddressScreen()),),
                  TListTile(icon: Iconsax.shopping_bag, title: 'My Cart', subTitle: 'Add, remove products and move to checkout',onTap: () => Get.to(() => TCard())),
                  TListTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress & complete order',onTap: () => Get.to(() => TOrder()),),
                  TListTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account',onTap: (){},),
                  TListTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all disconnected coupons',onTap: (){},),
                  TListTile(icon: Iconsax.notification, title: 'Notification', subTitle: 'Set any kind of notification message',onTap: (){},),
                  TListTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data use and connected account',onTap: (){},),
                  SizedBox(height: 32,),

                  // App Settings
                  TSectionHeading(title: 'App Settings',showActionBar: false,),
                  SizedBox(height: 16,),

                  TListTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload data to your Cloud Firebase'),
                  TListTile(
                    icon: Iconsax.location,
                    title: 'Geo-Location',
                    subTitle: 'Set recommendation base on location',
                    trailing: Switch(value: false, onChanged: (value){}),
                  ),
                  TListTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: true, onChanged: (value){}),
                  ),
                  TListTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set Image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value){},),
                  ),

                  SizedBox(height: 32,),
                  SizedBox(width: 110,child: ElevatedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: Text('Logout')))

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

