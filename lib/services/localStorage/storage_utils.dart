import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils{
  static void writevalueinstorage(String key, String value) {
    GetStorage().write(key, value);
  }

  static String readvaluefromgetstorage(String key) {
    if (GetStorage().read(key) == null) {
      return "";
    } else {
      return GetStorage().read(key);
    }
  }

  // static String? readvaluefromgetstorage(String key) {
  //   return GetStorage().read(key);
  // }

  static void writeboolvalue(String key, bool value) {
    GetStorage().write(key, value);
  }

  static bool readboolvalue(String key) {
    if (GetStorage().read(key) == null) {
      return false;
    } else {
      return GetStorage().read(key);
    }
  }

  static void writeDataInStorage(String key, dynamic value) {
    if (value is DocumentReference) {
      GetStorage().write(key, value.path);
    } else {
      GetStorage().write(key, value);
    }
  }

  static dynamic readDataFromStorage(String key) {
    print("readDataFromStorage "+key);
    if (GetStorage().read(key) == null) {
      return null;
    } else {
      return GetStorage().read(key);
    }
  }

}