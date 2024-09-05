
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/firebase/audit_fields_model.dart';
import '../../../utils/core/app_strings.dart';



final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<DocumentReference?> getUserDocumentReferenceNew(String collectionName,String userId) async {
  try {
    DocumentReference documentReference = _firestore.collection(collectionName).doc(userId);
    log('documentReference: $documentReference');
    return documentReference;
  } catch (e) {
    log('Error getting user document reference: $e');
    return null;
  }
}

Future<DocumentReference?> getDocumentReferenceNew(String collectionName,String userId) async {
  try {
    DocumentReference documentReference = _firestore.collection(collectionName).doc(userId);
    log('documentReference: $documentReference');
    return documentReference;
  } catch (e) {
    log('Error getting user document reference: $e');
    return null;
  }
}

Future<void> addAuditFields(String collection, String docId) async {
  // DocumentReference<Object?>? createdBy = await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);
  DocumentReference<Object?>? modifiedBy = await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);
  DocumentReference<Object?>? createdBy =await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);
  AuditFields data = AuditFields(createdBy: createdBy!, createdDateTime: Timestamp.now(), modifiedBy: modifiedBy!, modifiedDateTime:  Timestamp.now());
  Map<String,dynamic> datainJson = data.toJson();
  log("this is datainJson : $datainJson");
  log("addAuditFields run");
  // StorageUtils.writeDataInStorage(Preference.user_AuditFields, datainJson);
  await _firestore.collection(collection).doc(docId).update({'auditFields': datainJson}).onError((e, _) => log("Error in updating document: $e"));
}

Future<void> updateAuditFields(String collection, String docId) async {
  DocumentReference<Object?>? createdBy = await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);
  DocumentReference<Object?>? modifiedBy = await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);

  Map<String, dynamic> dataInJson = {};
  dataInJson["modifiedBy"] = modifiedBy;
  dataInJson["modifiedDateTime"] = Timestamp.now();
  log("updateAuditFields run");
  await _firestore.collection(collection).doc(docId).update({'auditFields.modifiedBy': modifiedBy,"auditFields.modifiedDateTime": Timestamp.now()}).onError((e, _) => log("Error in updating document: $e"));
  // await _firestore.collection(collection).doc(docId).update({'auditFields.modifiedDateTime': Timestamp.now()}).onError((e, _) => log("Error in updating document: $e"));
}

Future<bool> isDocumentExist (String collectionName, String docName) async{
  log("isDocumentExist ");
  DocumentSnapshot<Map<String,dynamic>> document =
      await _firestore.collection(collectionName).doc(docName).get();
  if(document.exists){
    return true;
  }
  else{
    return false;
  }

}