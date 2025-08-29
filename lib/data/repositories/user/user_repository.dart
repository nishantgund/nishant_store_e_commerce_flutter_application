import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/authentication/models/user_model.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;


  // Function to store user data into Firebase
  Future<void> saveUserRecord(UserModel user) async {
    try{
      await db.collection('User').doc(user.id).set(user.toJSON());
    }
    catch (e) {
      throw 'Something went wrong while storing data in firebase fireStore';
    }
  }

  // Function to fetch user data from Firebase
  Future<UserModel> fetchUserDetails() async {
    try{
      final documentSnapshot = await db.collection('User').doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }
      else{
        return UserModel.empty();
      }
    }
    catch (e) {
      throw 'Something went wrong while fetching data in firebase fireStore';
    }
  }

  // Function to Update user data from Firebase
  Future<void> updateUserDetails(UserModel updateUser) async {
    try{
      await db.collection('User').doc(updateUser.id).update(updateUser.toJSON());
    }
    catch (e) {
      throw 'Something went wrong while Updating data in firebase fireStore';
    }
  }

  // Function to Update Specific field of user data from Firebase
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try{
      await db.collection('User').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    }
    catch (e) {
      throw 'Something went wrong while Updating Specific field in firebase fireStore';
    }
  }

  // Function to Remove the user data from Firebase
  Future<void> removeUserRecord(String userId) async {
    try{
      await db.collection('User').doc(userId).delete();
    }
    catch (e) {
      throw 'Something went wrong while Removing data from firebase fireStore';
    }
  }

  // cloud
  static const String cloudName = 'daruepz2t';
  static const String uploadPreset = 'profile_store';
  //static const String uploadPreset = 'ml_default';

  // Upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try{

      //final mimeTypeData = lookupMimeType(path);
      final mimeTypeData = lookupMimeType(image.path)?.split('/');
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');

      final request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['public_id'] = 'Users/Images/Profile/${DateTime.now().millisecondsSinceEpoch}'
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              image.path,
              contentType: mimeTypeData != null ? MediaType(mimeTypeData[0], mimeTypeData[1]) : null,
            )
          );

      final response = await request.send();
      final result = await http.Response.fromStream(response);

      if(response.statusCode == 200){
        final data = jsonDecode(result.body);
        return data['secure_url'];
      }
      else{
        print("Failed : \${result.body}");
        return '';
      }

    }
    catch(e) {
      throw e.toString();
    }
  }

}