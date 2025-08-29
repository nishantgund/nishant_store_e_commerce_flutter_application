import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryModel{
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.image,
    required this. name,
    this.parentId ="",
    required this.isFeatured
  });

  // empty helper function
  static CategoryModel empty() => CategoryModel(id: '', image: "", name: "", isFeatured: false);

  // convert model to JSON Structure so that you can store data in firebase
  Map<String, dynamic> toJSON(){
    return{
      'Name' : name,
      'Image' : image,
      'ParentId' : parentId,
      'IsFeatured' : isFeatured
    };
  }

  // Map JSON oriented document SnapShot from Firebase to user model
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;

      // Map JSON Record to model. it is done for only store data in firebase database
      return CategoryModel(
          id: document.id,
          image: data['Image'] ?? '',
          name: data['Name'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
      );
    }
    else{
      return CategoryModel.empty();
    }
  }

}