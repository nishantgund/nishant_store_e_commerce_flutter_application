import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/features/personalization/screens/address/t_add_new_address_screen.dart';
import 'package:nishant_store/features/personalization/screens/address/t_single_address.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class TUserAddressScreen extends StatelessWidget {
  const TUserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    bool dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsData.blue,
        onPressed: () => Get.to(() => TAddNewAddress()),
        child: Icon(Icons.add, color: Colors.white,),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Address', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Obx(
              () => FutureBuilder(
              // use key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddress(),
              builder: (context, asyncSnapshot) {

                const loader = TShimmerEffects(width: double.infinity, height: 150);

                if(asyncSnapshot.connectionState == ConnectionState.waiting){
                  return loader;
                }

                if(!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty){
                  return Center(child: Text('No Data Found!'),);
                }

                if(asyncSnapshot.hasError){
                  return Center(child: Text('Something went Wrong'),);
                }

                final addresses = asyncSnapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => TSingleAddress(address: addresses[index], onTap: () => controller.selectAddress(addresses[index])),
                );
              }
            ),
          )
        ),
      ),
    );
  }
}
