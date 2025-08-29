import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/common/widgets/vertical_product_shimmer_effect.dart';
import 'package:nishant_store/features/shop/controllers/all_product_controller.dart';
import 'package:nishant_store/features/shop/screens/all%20product/t_sort_able_products.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../models/product_model.dart';

class TAllProduct extends StatelessWidget {
  const TAllProduct({super.key, required this.title, this.query, this.featureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? featureMethod;

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
            future: featureMethod ?? controller.fetchProductByQuery(query),
            builder: (context, asyncSnapshot) {
              const loader = VerticalProductShimmerEffect();
              if(asyncSnapshot.connectionState == ConnectionState.waiting){
                return loader;
              }

              if(!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty){
                return Center(child: Text('No Data Found!'),);
              }

              if(asyncSnapshot.hasError){
                return Center(child: Text('Something went Wrong'),);
              }

              // Product found
              final product = asyncSnapshot.data;

              return TSortableProducts(product: product!);
            }
          ),
        ),
      ),
    );
  }
}

