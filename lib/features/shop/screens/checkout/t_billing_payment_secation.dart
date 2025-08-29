import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import '../../controllers/product/checkout_controller.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final checkoutController = Get.put(CheckoutController());
    return Obx(
      () => Column(
        children: [
          TSectionHeading(title: 'Payment Method',buttonTitle: 'Change', onPressed: () => checkoutController.selectPaymentMethod(context),),
          SizedBox(height: 16,),
          Row(
            children: [
              Container(
                height: 35,
                width: 60,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: dark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image(image: NetworkImage(checkoutController.selectedPaymentMethod.value.image),fit: BoxFit.contain,),
              ),
              SizedBox(width: 8,),
              Text(checkoutController.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        ],
      ),
    );
  }
}
