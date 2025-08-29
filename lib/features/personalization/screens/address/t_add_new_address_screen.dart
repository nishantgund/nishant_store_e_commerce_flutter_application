import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/controllers/address_controller.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';

class TAddNewAddress extends StatelessWidget {
  const TAddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    bool dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
        title: Text('Add New Address', style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: controller.name,
                    validator: (value) => TValidator.validateEmptyText('Name', value),
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => TValidator.validatePhoneNumber(value),
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                        controller: controller.street,
                        validator: (value) => TValidator.validateEmptyText('Street', value),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'),
                      )),
                      SizedBox(width: 8,),
                      Expanded(child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => TValidator.validateEmptyText('PostalCode', value),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Pin Code'),
                      )),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                        controller: controller.city,
                        validator: (value) => TValidator.validateEmptyText('City', value),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'),
                      )),
                      SizedBox(width: 8,),
                      Expanded(child: TextFormField(
                        controller: controller.state,
                        validator: (value) => TValidator.validateEmptyText('State', value),
                        decoration: InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'),
                      )),
                    ],
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: controller.country,
                    validator: (value) => TValidator.validateEmptyText('Country', value),
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => controller.addNewAddress(), child: Text('Save')))

                ],
              )
          ),
        ),
      ),
    );
  }
}
