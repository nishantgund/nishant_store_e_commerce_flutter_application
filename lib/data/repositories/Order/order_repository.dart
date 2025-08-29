import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  // Get all order to related to current user
  Future<List<OrderModel>> fetchUserOrders() async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information';

      final result = await db.collection('User').doc(userId).collection('Orders').get();
      return result.docs.map((snapshot) => OrderModel.fromSnapshot(snapshot)).toList();
    }
    catch(e) {
      throw e.toString();
    }
  }

  // store user new order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try{
      await db.collection('User').doc(userId).collection('Orders').add(order.toJSON());
    }
    catch(e){
      throw e.toString();
    }
  }

}