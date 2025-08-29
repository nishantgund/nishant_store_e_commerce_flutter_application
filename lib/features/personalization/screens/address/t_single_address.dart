import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/features/personalization/models/addresses_model.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap, });

  final AddressModel address;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    bool dark = THelperFunction.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom:8 ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: selectedAddress ? ColorsData.blue.withOpacity(0.8): Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: selectedAddress ? Colors.transparent : dark ? Colors.grey.withOpacity(0.6) : Colors.grey)
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 16,
                  child: Icon(selectedAddress ? Iconsax.tick_circle5 : null, color: selectedAddress ? dark ? Colors.white : Colors.black : null,size: 30,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 4,),
                    Text('(+91) - ${address.phoneNumber}',overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 4,),
                    Text(address.toString(), softWrap: true,),
                  ],
                )
              ],
            ),
        ),
      );
      }
    );
  }
}
