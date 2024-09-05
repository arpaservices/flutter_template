import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/firebase/user_model.dart';
import '../../models/generic/api_response.dart';
import '../../services/Firebase/Firestore/auditFields.dart';
import '../../services/Firebase/Firestore/createNewEntity.dart';
import '../../services/Firebase/Firestore/getEntity.dart';
import '../../services/Firebase/Firestore/updateEntity.dart';
import '../../utils/core/app_strings.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<LoginUser?> getUser(String userId) async {
    try {
      ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response  = await getEntityRecord(FirebaseCollection.users, userId) ;
      if(response.status=="success"){
        LoginUser returneduser = await LoginUser.fromSnapshot(response.data!);
        return returneduser;
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
  }
  // Future<User?> setUserDetails(String userId) async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc("AS8n2kKK2DVSKPIUsZ7c").get();
  //     if (documentSnapshot.exists) {
  //       log(message)("This is documentSnapshot.data() ${docuffmentSnapshot.data()}");
  //       return User.fromSnapshot(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     log(message)('Error fetching user data: $e');
  //     return null;
  //   }
  // }

  // Future<ApiResponse<T>?> createEntityRecordWithJson<T>(

  Future<T?> getCollectionDetails<T>(String collection, String docID) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection(collection).doc(docID).get();
      return documentSnapshot.data as T?;
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
  }



  // Future<ApiResponse<Map<String, dynamic>>?> createUserNewViaJson(LoginUser user) async {
  //   log(message)("createUserNewViaJson ");
  //   try {
  //     if (user.id != null){
  //       log(message)("user,emailAddress "+user.emailAddress.toString());
  //       log(message)("user,name "+user.name.toString());
  //       log(message)("user,phoneNumber "+user.phoneNumber.toString());
  //       log(message)("user,profileImage "+user.profileImage.toString());
  //       ApiResponse<Map<String, dynamic>>? response  = await createEntityRecordWithJson(FirebaseCollection.users,user.id!,user.toJson() ) ;
  //       log(message)("response newUser $response");
  //       // updateAuditFields(FirebaseCollection.users,user.id!);
  //       log(message)(response.toString());
  //       return response;
  //     }
  //     log(message)('Error fetching user try data');
  //     return null;
  //   } catch (e) {
  //     log(message)('Error fetching user data: $e');
  //     return null;
  //   }
  // }

  Future<ApiResponse<LoginUser>> createNewUser(LoginUser user) async {
    try {
      if (user.id== null){
        return ApiResponse(status: "failed", message: "User ID not present",data:null );
    } else{
        if(await isDocumentExist(FirebaseCollection.users,user.id!)){
          // ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response= await updateDocument(FirebaseCollection.users,user.id!,user.toJson(),);
          // LoginUser updatedUser =await LoginUser.fromSnapshot(response.data!);
          // log(message)("This is input user ID" + user.id!);
          // return ApiResponse(status: "success", message: "success",data: user );
          // return ApiResponse(status: "success", message: "success",data: await getUser(user.id!));

          // ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response  = await createEntityRecordWithJsonNew(FirebaseCollection.users,user.id!,user.toJson() ) ;
          // if(response.status=="success"){
          //   addAuditFields(FirebaseCollection.users, user.id!);
          //   LoginUser returneduser = await LoginUser.fromSnapshot(response.data!);
          //   return ApiResponse(status: "success", message: "success",data:returneduser );
          // }
          // else{
          //   return ApiResponse(status: "unSuccessful", message: "User Creation Error",data:null );
          // }

          log("isDocumentExist exist");
          ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response  = await updateDocument(FirebaseCollection.users,user.id!,user.toJson());
          if(response.status=="success"){
            updateAuditFields(FirebaseCollection.users, user.id!);
            return ApiResponse(status: "success", message: "success",data: await getUser(user.id!));
          }
          else{
            return ApiResponse(status: "unSuccessful", message: "User Creation Error",data:null );
          }

          // await _firestore.collection(FirebaseCollection.users).doc(user.id!).update(user as Map<String, dynamic>);
          // return ApiResponse(status: "success", message: "success",data: await getUser(user.id!));

        }
        else
        {
          log("isDocumentExist not exist");
          ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response  = await createEntityRecordWithJsonNew(FirebaseCollection.users,user.id!,user.toJson() ) ;
          if(response.status=="success"){
            addAuditFields(FirebaseCollection.users, user.id!);
            LoginUser returneduser = await LoginUser.fromSnapshot(response.data!);
            return ApiResponse(status: "success", message: "success",data:returneduser );
          }
          else{
            return ApiResponse(status: "unSuccessful", message: "User Creation Error",data:null );
          }
        }
      }
    }catch (e) {
      log('Error fetching user data: $e');
      return ApiResponse(status: "error", message: "Failed with error" ,data: null);
    }
  }



  // Future<ApiResponse<Map<String, dynamic>>?> getCollection(String collection,LoginUser user) async {
  //
  //   log(message)("getCollection");
  //   try {
  //     if (user != null){
  //       LoginUser? response  = await fetchEntityRecord(collection,user.id!) ;
  //       log(message)("response getCollection $response");
  //       if (response != null){
  //         return ApiResponse(status: "success", message: "Data Created Successfully",data: response!.toJson());
  //       }
  //     }else{
  //       log(message)('Error fetching user try data');
  //       return null;
  //     }
  //   } catch (e) {
  //     log(message)('Error fetching user data: $e');
  //     return null;
  //   }
  //   log(message)('No response from  getCollection ');
  //   return null;
  // }

  Future<T?> editEntityRecordNew<T >(
      String collectionName,
      String docId,
      T data,
      ) async {
    try {
      bool isDocumentPresent =await isDocumentExist(collectionName,docId);
      if(isDocumentPresent){
        updateDocument(collectionName,docId,data);
      }
    } catch (e) {
      log('Error creating entity record: $e');
      return null;
    }
  }


}


