import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/card/t_card_item.dart';
import 'package:nishant_store/features/shop/screens/card/t_product_quantity_add_remove_button.dart';



class TCardItems extends StatelessWidget {
  const TCardItems({
    super.key, this.showAddRemoveButtons = true ,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_,_) => SizedBox(height: 32,),
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) => Obx(
              () {
                final item = cartController.cartItems[index];
                return Column(
                  children: [
                    // Image & Details
                    TCardItem(cartItem: item),
                    if(showAddRemoveButtons) SizedBox(height: 16,),

                    // Add & Remove Product with Price
                    if(showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Extra Space
                              SizedBox(width: 87,),
                              // Add Remove Button
                              TProductQuantityWithAddRemoveButton(
                                quantity: item.quantity,
                                remove:  () => cartController.removeOneFromCart(item),
                                add: () => cartController.addOneToCart(item),
                              ),
                            ],
                          ),

                          // Price
                          Text((
                              item.price * item.quantity).toStringAsFixed(1),
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                  ],
                );
              }
              ),
      ),
    );
  }
}