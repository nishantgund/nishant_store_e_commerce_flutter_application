import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/common/widgets/vertical_product_shimmer_effect.dart';
import 'package:nishant_store/features/shop/controllers/product/brand_controller.dart';
import 'package:nishant_store/features/shop/models/product_model.dart';
import 'package:nishant_store/features/shop/screens/all%20product/t_sort_able_products.dart';
import 'package:nishant_store/features/shop/screens/store/t_brand_card.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

class TBrandProducts extends StatelessWidget {
  const TBrandProducts({super.key, required this.brand});

  final Brands brand;

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text(brand.name ?? "", style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Brand detail
              TBrandCard(showBoarder: true,brand: brand),
              SizedBox(height: 16,),

              FutureBuilder(
                future: brandController.getBrandProducts(brandId: brand.id ?? ""),
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

                  return TSortableProducts(product: product ?? [],);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
