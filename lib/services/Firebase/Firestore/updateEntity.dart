
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/generic/api_response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> updateDocument<T>(
    String collectionName,
    String docId,
    T data,
    ) async {
  try {
    await _firestore.collection(collectionName).doc(docId).update(data as Map<String, dynamic>);
    DocumentSnapshot<Map<String, dynamic>> docSnap = await _firestore.collection(collectionName).doc(docId).get();
    // log(message)("this isupdate doc at update entity ${docSnap.toString()}");
    if (docSnap.exists) {
      log("This is documentSnapshot  at updateDocument :$docSnap");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "success", data: docSnap);
    } else {
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "unsuccessful", data: null);
    }
  } catch (e) {
    log('Error Updating entity record: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "error", message: "unsuccessful", data: null);
  }
}

