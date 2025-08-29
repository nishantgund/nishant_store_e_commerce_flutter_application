import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/Address/address_repository.dart';
import 'package:nishant_store/features/personalization/models/addresses_model.dart';
import 'package:nishant_store/features/personalization/screens/address/t_add_new_address_screen.dart';
import 'package:nishant_store/features/personalization/screens/address/t_single_address.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/utils/network_manager/network_maneger.dart';
import 'package:nishant_store/utils/popups/full_screen_loader.dart';
import 'package:nishant_store/utils/popups/loaders.dart';
import '../../../utils/constants/image_strings.dart';

class AddressController extends GetxController{
  static AddressController get instance => Get.find();

  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  // return all user address
  Future<List<AddressModel>> getAllUserAddress() async {
    try{
      final address = await addressRepository.fetchUserAddress();
      selectedAddress.value = address.firstWhere((address) => address.selectedAddress, orElse: () => AddressModel.empty());
      return address;
    }
    catch(e){
      Loaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }


  // function to add and remove selectedAddress value
  Future selectAddress(AddressModel newSelectedAddress) async {
    try{
      // clear the selected field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign Selected Address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // set the "Selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
    }
    catch(e){
      Loaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  //
  Future addNewAddress() async {
    try{

      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are Processing', TImages.searchingAnimation);

      // check Internet connection
      final isConnected = await TNetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!addressFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true
      );
      final id = await addressRepository.addAddress(address);

      // update selected address status
      address.id = id;
      await selectedAddress(address);

      // remove loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulation', message: 'Your Address has been Saved Successfully');

      // Refresh address Data
      refreshData.toggle();

      // Reset Field
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();

    }
    catch(e){
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // show addresses model bottom sheet at checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: 'Select Address',showActionBar: false, ),
              SizedBox(height: 32,), 
              FutureBuilder(
                    future: getAllUserAddress(),
                    builder: (_,snapshot){

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // loading state
                      }
                      else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}")); // error state
                      }
                      else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No Method found")); // empty list state
                      }

                      final addressList = snapshot.data!;

                      return ListView.builder(
                          itemCount: addressList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) => TSingleAddress(
                              address: addressList[index],
                              onTap: () async {
                                await selectAddress(addressList[index]);
                                Get.back();
                              }
                          )
                      );
                    }
                    ),
              SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => TAddNewAddress()), child: Text('Add New Address')),
              )
            ],
          ),

        )
    );
  }

  // function to reset form fields
  void resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    state.clear();
    postalCode.clear();
    city.clear();
    country.clear();
  }


}