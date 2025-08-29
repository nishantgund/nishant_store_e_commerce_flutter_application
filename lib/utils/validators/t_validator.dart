import 'package:flutter/material.dart';


class TValidator{

  static String? validateEmptyTextField(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required';
    }
  }

  static String? validateEmail( String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value){

    if(value == null || value.isEmpty){
      return 'Password is required';
    }

    // check for minimum length password
    if(value.length < 6){
      return 'Password must be at least 6 character long';
    }

    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must be contain at least one upper case';
    }

    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must be contain at least one number';
    }

    if(!RegExp(r'^(?=.*[!@#\$%\^&\*\(\),\.\?":\{\}\|<>]).+$').hasMatch(value)){
      return 'Password must be contain at least one special character';
    }

    return null;
  }

  static String? validateEmptyText(String? fieldName ,String? value){

    if(value == null || value.isEmpty){
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePhoneNumber( String? value){
    if(value == null || value.isEmpty){
      return 'phone number is required';
    }

    final phoneNumberRegExp = RegExp(r'^\d{10}$');
    if(!phoneNumberRegExp.hasMatch(value)){
      return 'Invalid phone number format (10 digit required)';
    }
    return null;
  }

}