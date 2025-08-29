import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(title: 'Shopping Address', buttonTitle: 'Change',onPressed: () => controller.selectNewAddressPopup(context),),
          controller.selectedAddress.value.id.isNotEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge,),
              SizedBox(height: 8,),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey, size: 16,),
                  SizedBox(width: 16,),
                  Text('+91 - ${controller.selectedAddress.value.phoneNumber}', style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Icon(Icons.location_history, color: Colors.grey, size: 16,),
                  SizedBox(width: 16,),
                  Text(controller.selectedAddress.value.toString(), style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)
                ],
              )
            ],
          ) : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium,)

        ],
      ),
    );
  }
}
