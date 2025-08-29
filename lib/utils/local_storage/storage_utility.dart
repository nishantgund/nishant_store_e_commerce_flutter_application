import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TLocalStorage{

  // crate variable of GetStorage type
  late final GetStorage storage;

  // Singleton instance
  static TLocalStorage? _instance;

  //
  TLocalStorage.internal();

  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage.internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage.internal();
    _instance!.storage = GetStorage(bucketName);
  }

  // Generic method to save data
  // here 'T' can be any type of data {String, int, bool, List<String>, Map<String, dynamic>}
  Future<void> saveData<T>(String key, T value) async {
    await storage.write(key, value);
  }

  //  Generic method to read data
  // here 'T' can be any type of data {String, int, bool, List<String>, Map<String, dynamic>}
  T? readData<T>(String key) {
    return storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await storage.remove(key);
  }

  // clear all data from storage
  Future<void> clearAll() async {
    await storage.erase();
  }

}