import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;


  // Get all Banners
  Future<List<BannerModel>> getAllBanners() async{
    try{
      final snapshot = await db.collection('Banners').where('active', isEqualTo: true).get();
      final list = snapshot.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      return list;
    }
    catch(e){
      throw e.toString();
    }
  }


}