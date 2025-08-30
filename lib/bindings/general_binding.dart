import 'package:get/get.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/favourite_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/variation_controller.dart';
import 'package:nishant_store/utils/network_manager/network_maneger.dart';

class GeneralBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(TNetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(FavouriteController());
    Get.put(CheckoutController());
  }}