import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/screens/card/t_card_items.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_billing_address_section.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_billing_amount_section.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_billing_payment_secation.dart';
import 'package:nishant_store/features/shop/screens/checkout/t_coupan_code.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/helpers/pricing_calculator.dart';
import 'package:nishant_store/utils/popups/loaders.dart';
import '../../controllers/product/order_controller.dart';

class TCheckoutScreen extends StatelessWidget {
  const TCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);

    final cartController = CartController.instance;
    final subtotal = cartController.totalCartPrice.value;

    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subtotal, 'US');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Order Review', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // Items in Card
              TCardItems(showAddRemoveButtons: false,),
              SizedBox(height: 32,),

              // Coupon Text-Field
              TCouponCode(),
              SizedBox(height: 32,),

              //  Billing Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: dark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: dark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    SizedBox(height: 16,),

                    // Divider
                    Divider(),
                    SizedBox(height: 16,),

                    // Payment methods
                    TBillingPaymentSection(),
                    SizedBox(height: 16,),

                    // Address
                    TBillingAddressSection(),

                  ],
                ),
              )
            ],
          ),
        ),
      ),

      // Checkout Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: subtotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => Loaders.warningSnackBar(title: 'Empty Cart', message: 'Add item in the cart in order to process. '),
            child: Text('Checkout \$$totalAmount')),
      ),
    );
  }
}


