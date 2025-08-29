import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{

  // keep those value final those you don't want to change
  final String id;
  String firstName;
  String lastName;
  final String userame;
  final String email;
  String phoneNumber;
  String profilrPicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userame,
    required this.email,
    required this.phoneNumber,
    required this.profilrPicture
  });


  String get fullName => '$firstName $lastName';
  String get formattedPhoneNumber => '+91$phoneNumber';
  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName){

    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ?nameParts[0].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }

  // create an empty user model
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', userame: '', email: '', phoneNumber: '', profilrPicture: '');

  // Function that convert model to JSON Structure for storing data in Firebase
  Map<String, dynamic> toJSON(){
    return{
      'FirstName' : firstName,
      'LastName' : lastName,
      'username' : userame,
      'Email' : email,
      'PhoneNumber' : phoneNumber,
      'ProfilePicture' : profilrPicture,
    };
  }

  // Factory method to create userModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? "",
          lastName: data['LastName'] ?? "",
          userame: data['username'] ?? "",
          email: data['Email'] ?? "",
          phoneNumber: data['PhoneNumber'] ?? "",
          profilrPicture: data['ProfilePicture'] ?? "",
      );
    }
    else{
      return UserModel.empty();
    }
  }

}
