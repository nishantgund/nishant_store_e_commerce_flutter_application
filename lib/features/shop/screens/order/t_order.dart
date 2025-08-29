import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/order_controller.dart';
import 'package:nishant_store/utils/constants/colors.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/popups/animation_loader.dart';

import '../../../../navigation_menu.dart';

class TOrder extends StatelessWidget {
  const TOrder({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Order Review', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: FutureBuilder(
          future: controller.fetchUserOrders(),
          builder: (context, asyncSnapshot) {
            // Nothing Found Widgets
            final emptyWidget = TAnimationLoader(
              text: 'Whoops No Order yet',
              animation: 'assets/images/animation/empty.json',
              showAction: true,
              actionText: 'Let\'s fill it',
              onActionPressed: () => Get.offAll(() => TNavigationMenuScreen()),
            );

            if(asyncSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }

            if(!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty){
              return emptyWidget;
            }

            if(asyncSnapshot.hasError){
              return Center(child: Text('Something went Wrong'),);
            }

            final orders = asyncSnapshot.data!;

            return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (__,_) => SizedBox(),
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey.withOpacity(0.3) : Colors.white60,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: dark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.3) ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Row 1
                      Row(
                        children: [
                          // 1 Item
                          Icon(Iconsax.ship),
                          SizedBox(width: 8,),

                          // Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyLarge!.apply(color: ColorsData.blue, fontWeightDelta: 1),
                                ),
                                Text(
                                  controller.formatDate(order.orderDate),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),

                          // Icon
                          IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_3, size: 16,))
                        ],
                      ),
                      SizedBox(height: 16,),

                      // Row 2
                      Row(
                        children: [
                          // Order Number
                          Expanded(
                            child: Row(
                              children: [
                                // 1 Item
                                Icon(Iconsax.tag),
                                SizedBox(width: 8,),

                                // Status & Date
                                 Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order', style: Theme.of(context).textTheme.labelMedium),
                                      Text(order.id.toString(), overflow:  TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                ),
                              ],
                            ),
                          ),

                          // Shipping Date
                          Expanded(
                            child: Row(
                              children: [
                                // 1 Item
                                Icon(Iconsax.calendar),
                                SizedBox(width: 8,),

                                // Status & Date
                                 Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('shipping Date', style: Theme.of(context).textTheme.labelMedium),
                                      Text(controller.formatDate(order.deliveryDate!),overflow:  TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              );
              }
            );
          }
        ),
    );
  }
}
