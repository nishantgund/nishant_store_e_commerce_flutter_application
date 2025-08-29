import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nishant_store/features/shop/models/category_model.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  // Get all Categories
  Future<List<CategoryModel>> getAllCategories() async{
    try{
      final data = await db.collection('categories').get();
      final list = data.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    }
    catch(e){
      throw e.toString();
    }
  }

  // Get All Sub-Category
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try{
      final data = await db.collection('categories').where('ParentId', isEqualTo: categoryId).get();
      final list = data.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    }
    catch(e){
      throw e.toString();
    }
  }

}