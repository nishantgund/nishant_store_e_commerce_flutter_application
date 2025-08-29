import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/features/shop/models/payment_method_model.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';

import '../../screens/checkout/payment_tile.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  void onInit(){
    super.onInit();
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: 'https://res.cloudinary.com/daruepz2t/image/upload/v1755348813/p8hucbitcgrlgijszrq0.png');
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) async {

    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSectionHeading(title: 'Select Payment Method', showActionBar: false,),
                SizedBox(height: 32,),
                FutureBuilder(
                    future: getPaymentMethods(), 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // loading state
                      }
                      else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}")); // error state
                      }
                      else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No Method found")); // empty list state
                      }

                      final list = snapshot.data;

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list!.length,
                          itemBuilder:(context, index) {
                            return TPaymentTile(paymentMethod: list[index]);
                          }
                      );

                    }
                ),
              ],
            ),
          ),
        )
    );
  }
  
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final snapshot = await FirebaseFirestore.instance.collection('Payment_Method').get();
    final paymentMethodList = snapshot.docs.map((paymentMethod) => PaymentMethodModel.fromSnapshot(paymentMethod.data())).toList();
    return paymentMethodList;
  }


}