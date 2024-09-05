

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/generic/api_response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> createEntityRecordWithJsonNew<T>(
    String collectionName,
    String docId,
    T data,
    ) async {
  try {
    await _firestore.collection(collectionName).doc(docId).set(data as Map<String,dynamic>);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection(collectionName).doc(docId).get();
    if (documentSnapshot.exists) {
      log("This is documentSnapshot at createEntity : ${documentSnapshot.data}");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "success", data: documentSnapshot);
    } else {
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "unsuccessful", data: null);
    }
    return ApiResponse(status: "success", message: "Data Created Successfully",data: documentSnapshot );
  } catch (e) {
    log('Error creating entity record: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "error", message: "unsuccessful", data: null);
  }
}

Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> createEntityRecord<T>(
    String collectionName,
    T data,
    ) async {
  try {
    log("THis is data to get input in createEntityRecord $data");
    DocumentReference<Map<String, dynamic>> documentRef = await _firestore.collection(collectionName).add(data as Map<String,dynamic>);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();
    if (documentSnapshot.exists) {
      log("This is documentSnapshot at createEntity : ${documentSnapshot.data()}");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "Data Created Successfully", data: documentSnapshot);
    } else {
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "Failed to create data", data: null);
    }
  } catch (e) {
    log('Error creating entity record: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "error", message: "Error creating entity record", data: null);
  }
}


// Future<T?> createEntityRecord<T extends Auditable>(
//     String collectionName,
//     T data,
//     ) async {
//   try {
//     DocumentReference<Object?>? createdBy = await getUserDocumentReferenceNew(FirebaseCollection.users,FirebaseAuth.instance.currentUser!.uid);
//     DocumentReference<Object?>? modifiedBy = await getUserDocumentReferenceNew(FirebaseCollection.users,FirebaseAuth.instance.currentUser!.uid);
//     data.auditfields = AuditFields(
//       createdBy: createdBy!,
//       createdDateTime: Timestamp.now(),
//       modifiedBy: modifiedBy!,
//       modifiedDateTime: Timestamp.now(),
//     );
//
//     DocumentReference documentReference = await _firestore.collection(collectionName).add(
//       data as Map<String,dynamic>
//     );
//     DocumentSnapshot documentSnapshot = await documentReference.get();
//     if (documentSnapshot.exists) {
//       T? result = documentSnapshot.data() as T?;
//       return result;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     log('Error creating entity record: $e');
//     return null;
//   }
// }


// Future<T?> createEntityRecordNew<T>(
//     String collectionName,
//     String userId,
//     T data,
//     ) async {
//   try {
//     var collection = _firestore.collection(collectionName);
//     var querySnapshots = await collection.get();
//     var snapshots = querySnapshots.docs.where((element) => (userId == element.id));
//     log("createEntityRecordNew "+snapshots.length.toString());
//     if (snapshots.isEmpty || snapshots.length == 0) {
//       // await collection.doc(userId).set(data.toJson());
//       log("IF LOOP");
//       await collection.doc(userId).set((data as LoginUser).toJson())
//           .onError((e, _) => log("Error in adding document: $e"));
//     }else{
//       log("ELSE LOOP");
//       DocumentReference<Object?>? createdBy = await getUserDocumentReferenceNew(FirebaseCollection.users, userId);
//       DocumentReference<Object?>? modifiedBy = await getUserDocumentReferenceNew(FirebaseCollection.users, userId);
//       // data.auditfields = AuditFields(
//       //   createdBy: createdBy!,
//       //   createdDateTime: Timestamp.now(),
//       //   modifiedBy: modifiedBy!,
//       //   modifiedDateTime: Timestamp.now(),
//       // );
//       // // await collection.doc(userId).set(data.toJson())
//       // //     .onError((e, _) => log("Error writing document: $e"));
//       // log("auditFields ${data.auditfields!.toJson()}");
//        Map<String, dynamic> dataInJson = {
//          "createdBy": createdBy,
//          "createdDateTime": Timestamp.now(),
//          "modifiedBy": modifiedBy,
//          "modifiedDateTime": Timestamp.now(),
//
//        };
//       await collection.doc(userId).update({'auditFields': dataInJson}).onError((e, _) => log("Error in updating document: $e"));
//     }
//     // log('set(data.toJson()) '+data.toJson().toString());
//
//     // final docRef = collection.doc(collectionName);
//     // docRef.get().then(
//     //       (DocumentSnapshot doc) {
//     //     final data = doc.data() as Map<String, dynamic>;
//     //     // ...
//     //   },
//     //   onError: (e) => log("Error getting document: $e"),
//     // );
//
//     DocumentSnapshot documentSnapshot = await collection.doc(userId).get();
//     if (documentSnapshot.exists) {
//       log('documentSnapshot.exists ');
//       T? result = documentSnapshot.data() as T?;
//       // final result = documentSnapshot.data() as Map<String, dynamic>;
//       return result as T;
//     } else {
//       return null;
//     }
//
//   } catch (e) {
//     log('Error creating entity record: $e');
//     return null;
//   }
// }
//

// Future<ApiResponse<T>?> createEntityRecordWithJson<T>(
//     String collectionName,
//     String docId,
//     T data,
//     ) async {
//   try {
//     var collection = _firestore.collection(collectionName);
//     bool isDocumentPresent =await isDocumentExist(collectionName,docId);
//     if(isDocumentPresent==false){
//       await collection.doc(docId).set((data as Map<String, dynamic>))
//           .onError((e, _) => log("Error in adding document: $e"));
//       addAuditFields(FirebaseCollection.users,docId);
//     }
//     else
//       {
//         log("Data with same docId already present");
//         await collection.doc(docId).update((data as Map<String, dynamic>))
//             .onError((e, _) => log("Error in updating document: $e"));
//         updateAuditFields(FirebaseCollection.users,docId);
//       }
//     return ApiResponse(status: "success", message: "Data Created Successfully",data: data );
//   } catch (e) {
//     log('Error creating entity record: $e');
//     return null;
//   }
// }

// Future<T?> fetchEntityRecordWithJson<T>(
//     String collectionName,
//     String docId)  async {
//   /*
// _firestore
//       .collection(collectionName)
//       .doc(docId)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       log('Document data: ${documentSnapshot.data()}');
//       return documentSnapshot.data();
//     } else {
//       log('Document does not exist on the database');
//     }
//   });
//   return null;
// */
//
//   // QuerySnapshot querySnapshot = await _firestore.collection(collectionName).where("id", isEqualTo: docId).get();
//   // if (querySnapshot.docs.length > 0){
//   //   // return querySnapshot.docs[0].data();
//   //   var docData = querySnapshot.docs[0];
//   //   return LoginUser.fromJson(querySnapshot.docs[0]);
//   //
//   // }
//
//   // await _firestore.collection(collectionName).where("id", isEqualTo: docId).get().then((QuerySnapshot querySnapshot) => {
//   //   querySnapshot.docs.forEach((doc) {
//   //     itemList.add(doc.data());
//   //   }),
//   //   return querySnapshot.docs[0]
//   // });
//   return null;
//
// }

// Future<LoginUser?> fetchEntityRecord<T>(
//     String collectionName,
//     String docId)  async {
//
//   QuerySnapshot querySnapshot = await _firestore.collection(collectionName).where("id", isEqualTo: docId).get();
//   if (querySnapshot.docs.length > 0){
//     var docData = querySnapshot.docs[0];
//     return LoginUser(id: docData["id"], name: docData["name"], profileImage: docData["profileImage"], phoneNumber: docData["phoneNumber"], emailAddress: docData["emailAddress"], gender: docData["gender"], isDeleted: docData["isDeleted"]);
//   }
//   return null;
//
// }

