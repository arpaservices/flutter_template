
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/generic/api_response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> getEntityRecord(String collectionName, String documentID) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection(collectionName).doc(documentID).get();
    if (documentSnapshot.exists) {
      log("This is documentSnapshot  getEntityRecord ${documentSnapshot.data()}");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "success", data: documentSnapshot);
    } else {
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "unsuccessful", data: null);
    }
  } catch (e) {
    log(''
        'Error fetching data: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "unsuccessful", data: null);
  }
}

Future<ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>> getEntityByQuery(String collectionName, Query inputQuery) async {
  try {
    // for (int i = 0; i < inputQuery['attributes'].length; i++) {
    //   String attributePath = inputQuery['attributes'][i].toString();
    //   String value = inputQuery['values'][i].toString();
    // }
    // String queryField = inputQuery["attributes"];
    QuerySnapshot querySnapshot = await inputQuery.get();
    List<DocumentSnapshot<Map<String, dynamic>>> matchingDocuments = querySnapshot.docs as List<DocumentSnapshot<Map<String, dynamic>>> ;
    if (matchingDocuments.isNotEmpty) {
      log("This is documentSnapshot  getEntityByQuery ${matchingDocuments.first.data()}");
      return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "success", message: "success", data: matchingDocuments);
    } else {
      return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "unsuccessful", message: "unsuccessful", data: null);
    }
  } catch (e) {
    log(''
        'Error fetching data: $e');
    return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "unsuccessful", message: "unsuccessful", data: null);
  }
}
Future<ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>> getAllCollection(String collectionName) async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
    List<DocumentSnapshot<Map<String, dynamic>>> matchingDocuments = querySnapshot.docs as List<DocumentSnapshot<Map<String, dynamic>>> ;
    if (matchingDocuments.isNotEmpty) {
      log("This is documentSnapshot  getEntityByQuery ${matchingDocuments.first.data()}");
      return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "success", message: "success", data: matchingDocuments);
    } else {
      return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "unsuccessful", message: "unsuccessful", data: null);
    }
  } catch (e) {
    log(''
        'Error fetching data: $e');
    return ApiResponse<List<DocumentSnapshot<Map<String, dynamic>>>>(status: "unsuccessful", message: "unsuccessful", data: null);
  }
}


Future<DocumentReference?> getDocumentReference(String collectionName,String docId) async {
  try {
    DocumentReference documentReference = _firestore.collection(collectionName).doc(docId);
    log('documentReference: $documentReference');
    return documentReference;
  } catch (e) {
    log('Error getting user document reference: $e');
    return null;
  }
}

// Future<List<Object>> getEntityListRecord(String collectionName,List<String>  documentIDList) async {
//   try {
//     DocumentSnapshot documentSnapshot = await _firestore.collection(collectionName);
//     if (documentSnapshot.exists) {
//       Object data = documentSnapshot.data()!;
//       return data;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     log('Error fetching user data: $e');
//     return null;
//   }
// }

DocumentReference getUserDocRef(String path)  {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference documentReference = firestore.doc(path);
  return documentReference;
}

