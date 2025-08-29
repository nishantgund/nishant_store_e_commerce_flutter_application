import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nishant_store/utils/popups/loaders.dart';
import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  static List<ProductModel> products = <ProductModel>[];

  void onInit(){
    super.onInit();
  }

  // Json file to ProductModel List Convert
  Future<void> jsonFileToProductList() async {
    final String response = await rootBundle.loadString('assets/products_with_images_words.json');
    final List<dynamic> data = await jsonDecode(response);
    products = await data.map((productModel) => ProductModel.fromJson(productModel)).toList();
    saveProductsList();
  }

  // Storing all Product List on Firebase FireStore Database
  Future<void> saveProductsList() async {
    try{
      for(int i = 0; i < products.length; i++){
        await db.collection('Product').doc(i.toString()).set(products[i].toJson());
      }
    }
    catch (e){
      throw e.toString();
    }
  }

  // Update Product Attributes
  Future<void> saveUpdateProductsAttributes() async {
    try{
      QuerySnapshot snapshot = await db
          .collection('Product') // 👈 replace with your collection name
          .where('Brands.Name', isEqualTo: 'Ikea')
          .get();

      for (var doc in snapshot.docs) {
        await db.collection('Product').doc(doc.id).update({
          'Brands.Image': "https://res.cloudinary.com/daruepz2t/image/upload/v1755348576/slkno2gsl7umvbqkspqk.png", // 👈 field you want to update
        });
      }
    }
    catch (e){
      throw e.toString();
    }
  }

  // Save Single new Product
  Future<void> saveProduct(ProductModel product) async {
    try{
      await db.collection('Product').doc(product.hashCode.toString()).set(product.toJson());
    }
    catch (e){
      throw e.toString();
    }
  }

  // Get Limited Feature Products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try{
      final snapshot = await db.collection('Product').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    }
    catch (e){
      throw e.toString();
    }
  }

  // Get All Feature Products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try{
      final snapshot = await db.collection('Product').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    }
    catch (e){
      throw e.toString();
    }
  }


  // fetch products by given query
  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try{
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      return productList;
    }
    catch (e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // fetch Favourite products
  Future<List<ProductModel>> getFavouriteProducts(List<String> productId) async {
    try{
      // Only return the documents or products those ID is inside the list productId.
      final snapshot = await db.collection('Product').where(FieldPath.documentId, whereIn: productId).get();
      final List<ProductModel> productList = snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return productList;
    }
    catch (e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // return brand related products
  Future<List<ProductModel>> getProductForBrand({ required String brandId, int limit = -1}) async {
    try{
      final snapshot = limit == -1
          ? await db.collection('Product').where('Brands.id', isEqualTo: brandId).get()
          : await db.collection('Product').where('Brands.id', isEqualTo: brandId).limit(limit).get();

      final product = snapshot.docs.map((product) {
        try{
          final data = product.data();
          if(data.isEmpty) return null;
          return ProductModel.fromJson(data);
        }
        catch(e){
          Loaders.errorSnackBar(title: "Null Safety", message: e.toString());
          return null;
        }
      }
      ).whereType<ProductModel>()
          .toList();
      //final product = snapshot.docs.map((product) => ProductModel.fromJson(product.data())).toList();
      return product;
    }
    catch(e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // return all products that belong to that give category
  Future<List<ProductModel>> getProductsForCategory({ required String categoryId, int limit = -1}) async {
    try{
      final snapshot = limit == -1
          ? await db.collection('Product').where('CategoryId', isEqualTo: int.parse(categoryId)).get()
          : await db.collection('Product').where('CategoryId', isEqualTo: int.parse(categoryId)).limit(limit).get();

      final product = snapshot.docs.map((product) {
        try{
          final data = product.data();
          if(data.isEmpty) return null;
          return ProductModel.fromJson(data);
        }
        catch(e){
          Loaders.errorSnackBar(title: "Null Safety", message: e.toString());
          return null;
        }
      }
      ).whereType<ProductModel>()
          .toList();
      //final product = snapshot.docs.map((product) => ProductModel.fromJson(product.data())).toList();
      return product;
    }
    catch(e){
      throw Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // add to the all products new attribute 'productId'
  Future<void> addProductIdField() async {
    // Get all products
    final snapshot = await db.collection('Product').get();

    for (var doc in snapshot.docs) {
      // Each doc.id is the Firestore document ID
      String productId = doc.id;

      // Update document by adding 'productId' field
      await db.collection('Product').doc(productId).update({
        "productId": productId,
      });

      print("Updated: $productId");
    }
  }


}
