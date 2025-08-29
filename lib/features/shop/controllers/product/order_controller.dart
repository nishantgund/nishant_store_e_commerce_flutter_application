import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nishant_store/data/repositories/Order/order_repository.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/cart_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:nishant_store/utils/constants/enum.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';
import 'package:nishant_store/utils/popups/loaders.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../authentication/screens/success_screen.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  // fetch user order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try{
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  // add methods for order processing
  void processOrder(double totalAmount) async {
    try{

      // start loader
      TFullScreenLoader.openLoadingDialog('Processing your order', 'assets/images/animation/searching.json');

      // get user authentication id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) return;

      final todayDate = DateTime.now();

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userid: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: todayDate,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: todayDate.add(Duration(days: 10)),
        items: cartController.cartItems.toList(),
      );

      // save the order to firestorm
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      Get.off(() => TSuccessScreen(
          image: TImages.successful_payment ,
          title: 'Payment Success!',
          subTitle: 'Your item will be Shipped Soon',
          onPressed: () => Get.offAll(() => TNavigationMenuScreen())
      ));

    }
    catch(e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  String formatDate(DateTime date){
    final String formattedDate = DateFormat("d MMM, y").format(date);
    return formattedDate;
  }

}