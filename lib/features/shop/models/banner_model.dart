import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
});

  String imageUrl;
  final String targetScreen;
  final bool active;

  Map<String, dynamic> toJson(){
    return {
      'active' : active,
      'imageUrl' : imageUrl,
      'targetScreen' : targetScreen
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
        imageUrl: data['imageUrl'] ?? '',
        targetScreen: data['targetScreen'] ?? '',
        active: data['active'] ?? false
    );
  }

}