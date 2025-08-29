import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel{
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true
  });

  //String get formattedPhoneNo => phoneNumber

  static AddressModel empty() => AddressModel(id: "", name: "", phoneNumber: "", street: "", city: "", state: "", postalCode: "", country: "");

  Map<String, dynamic> toJson(){
    return {
      "Id" : id,
      "Name" : name,
      "PhoneNumber" : phoneNumber,
      "Street" : street,
      "City" : city,
      "State" : state,
      "PostalCode" : postalCode,
      "Country" : country,
      "DateTime" : DateTime.now(),
      "SelectedAddress" : selectedAddress
    };
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final json = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
        id: snapshot.id,
        name: json['Name'] ?? "",
        phoneNumber: json['PhoneNumber'] ?? "",
        street: json['Street'] ?? "",
        city: json['City'] ?? "",
        state: json['State'] ?? "",
        postalCode: json['PostalCode'] ?? "",
        country: json['Country'] ?? "",
        dateTime: (json['DateTime'] as Timestamp).toDate(),
        selectedAddress: json['SelectedAddress'] as bool
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> json){
    return AddressModel(
        id: json['Id'] as String,
        name: json['Name'] as String,
        phoneNumber: json['PhoneNumber'] as String,
        street: json['Street'] as String,
        city: json['City'] as String,
        state: json['State'] as String,
        postalCode: json['PostalCode'] as String,
        country: json['Country'] as String,
        dateTime: (json['DateTime'] as Timestamp).toDate(),
        selectedAddress: json['SelectedAddress'] as bool
    );
  }

  String toString(){
    return '$street, $city, $state $postalCode, $country';
  }

}