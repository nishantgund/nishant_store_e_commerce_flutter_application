import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_model.dart';

class BrandsRepository extends GetxController{
  static BrandsRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  static Brands brand = Brands.empty();

  @override
  void onInit() {
    super.onInit();
  }

  // get brand from category
  void getBrand() async {
    try{
      final snapshot = await db.collection('Product').doc("31").get();
      final data = snapshot.data()!;
      brand = Brands.fromJson(data['Brands']);
      saveRecord();
    }
    catch (e){
      throw e.toString();
    }
  }

  // storing data into brands
  void saveRecord() async {
    await db.collection("Brands").doc(brand.id).set(brand.toJson());
  }

  // Get all Brands
  Future<List<Brands>> getAllBrands() async {
    try{
      final snapshot = await db.collection("Brands").get();
      final result = await snapshot.docs.map((brand) => Brands.fromJson(brand.data())).toList();
      return result;
    }
    catch(e){
      throw e.toString();
    }
  }

  // Get Brands that belong to that given category
  Future<List<Brands>> getBrandForCategory(String categoryId) async {
    try{
      // String to int convert
      int categoryID = int.parse(categoryId);

      // Getting all products that are belong to that category
      final snapshot = await db.collection('Product').where('CategoryId', isEqualTo: categoryID).get();

      // Get all Brands that belong to that products
      final products = snapshot.docs.map((products) => ProductModel.fromJson(products.data())).toList();

      // creating Set variable to Store only Unique Brands id
      Set<String> brandId = {};

      // products to brands
      for(var product in products){
        // null check
        if(product.brands!.id != null){
          final brand = product.brands!.id;
          // check brand id is present in brands id Set
          if(!brandId.contains(brand)){
            brandId.add(brand!);
          }
        }
      }

      // for unique Brands
      Set<Brands> brands = {};
      
      // fetching data
      for(var id in brandId){
        final snapshot =  await db.collection('Brands').where('id', isEqualTo: id).get();
        final brand = Brands.fromJson(snapshot.docs.first.data());
        brands.add(brand);
      }

      // returning the list with all unique brands
      return brands.toList();
    }
    catch(e){
      throw e.toString();
    }
  }

}