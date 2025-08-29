import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:nishant_store/features/shop/models/payment_method_model.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      onTap: (){
        checkoutController.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: Container(
        height: 40,
        width: 60,
        padding: EdgeInsets.all(4),
        color: THelperFunction.isDarkMode(context) ? Colors.black : Colors.white,
        child: Image(image: NetworkImage(paymentMethod.image), fit: BoxFit.contain,),
      ),
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}
