import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/personalization/models/addresses_model.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw "Unable to find user information";

      final result = await db.collection('User').doc(userId).collection('Addresses').get();
      return result.docs.map((snapshot) => AddressModel.fromDocumentSnapshot(snapshot)).toList();

    }
    catch(e){
      throw e.toString();
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await db.collection("User").doc(userId).collection("Addresses").doc(addressId).update({'SelectedAddress' : selected});
    }
    catch(e){
      throw e.toString();
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await db.collection('User').doc(userId).collection('Addresses').add(address.toJson());
      await db.collection('User').doc(userId).collection('Addresses').doc(currentAddress.id).update({"Id" : currentAddress.id});
      return currentAddress.id;
    }
    catch(e){
      throw e.toString();
    }
  }

}