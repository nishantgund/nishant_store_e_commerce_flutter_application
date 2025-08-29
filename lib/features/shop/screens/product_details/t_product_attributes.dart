import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/shop/controllers/product/product_controller.dart';
import 'package:nishant_store/features/shop/controllers/product/variation_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/product_details/t_choice_chip.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../models/product_model.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    final controller2 = Get.put(VariationController());
    //controller2.resetSelectedAttributes();
    return Obx(
      () {
        return Column(
        children: [
          SizedBox(height: 8,),
          // Selected Attributes, Pricing & Description
          if(controller2.selectedVariation.value.id!.isNotEmpty)
          Obx(() =>
              Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: dark ? Colors.grey.withOpacity(0.3) : Colors.grey.withOpacity(0.4)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Title, Price, Stock Status
                    Row(
                        children:[
                          TSectionHeading(title: 'Variation', showActionBar: false,),
                          SizedBox(width: 16,),

                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Price
                                Row(
                                  children: [
                                    Text('Price : '),

                                    // Actual Price
                                    if(controller2.selectedVariation.value.salePrice! > 0)
                                    Text('\$${controller2.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
                                    SizedBox(width: 8,),

                                    // Sale Price
                                    Text('\$${controller2.salePrice}', style: Theme.of(context).textTheme.headlineSmall)
                                  ],
                                ),

                                // Stock
                                Row(
                                  children: [
                                    Text('Stock : '),

                                    // Stock is available or not
                                    Text(controller2.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium),
                                    SizedBox(width: 8,),
                                  ],
                                )
                              ],
                            ),
                        ]
                    ),

                    // variation description
                    Text(controller2.selectedVariation.value.description!, style: Theme.of(context).textTheme.bodyMedium,maxLines: 2,overflow: TextOverflow.ellipsis,)

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),

          // Attributes
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.getAttributes(product)
                    .map((oneModel) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TSectionHeading(title: oneModel.name ?? "",showActionBar: false,),
                          SizedBox(height: 8,),
                          Obx(() =>
                              Wrap(
                                spacing: 8,
                                children: controller.getValues(oneModel.values!)
                                    .map((attributeValue) {
                                      final isSelected = controller2.selectedAttributes[oneModel.name] == attributeValue;
                                      // all variation list
                                      final allVariations = [
                                        product.productsVariation!.one,
                                        product.productsVariation!.two,
                                        product.productsVariation!.three,
                                      ].where((v) => v != null).cast<PVOne>().toList();
                                      final available = controller2
                                          .getAttributesAvailabilityInVariation(allVariations, oneModel.name!)
                                          .contains(attributeValue);

                                      return TChoiceChip(
                                        text: attributeValue,
                                        selected: isSelected,
                                        onSelected: available ? (selected){
                                          if(selected && available){
                                            controller2.onSelect(product, oneModel.name ?? "", attributeValue);
                                          }
                                        }
                                        : null,);
                                    }) .toList()
                              ),
                          ),
                        ],
                      )
                    ).toList()
          ),
        ],
      );
        },
    );
  }
}

