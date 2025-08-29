import 'package:flutter/material.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subtotal = controller.totalCartPrice.value;

    return Column(
      children: [
        // Sub Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subtotal', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: 8,),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shopping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${TPricingCalculator.calculateShippingCost(subtotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: 8,),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${TPricingCalculator.calculateTax(subtotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: 8,),

        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${TPricingCalculator.calculateTotalPrice(subtotal, 'US')}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
