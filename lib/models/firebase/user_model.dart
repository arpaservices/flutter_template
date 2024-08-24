import 'package:cloud_firestore/cloud_firestore.dart';

import 'audit_fields_model.dart';
import 'subscriptionDetails_model.dart';


class LoginUser extends Auditable{
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? phoneNumber;
  final String? emailAddress;
  final String? gender;
  final AuditFields? auditFields;
  final bool isDeleted;
  final SubscriptionDetails? subscriptionDetails;

  LoginUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.phoneNumber,
    required this.emailAddress,
    required this.gender,
    this.auditFields,
    required this.isDeleted,
    this.subscriptionDetails,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profileImage": profileImage,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
    "gender": gender,
    "isDeleted": isDeleted,
    "subscriptionDetails": subscriptionDetails,
    "userActivities":["USER"]
  };

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    emailAddress: json["emailAddress"] == null ? null : json["emailAddress"],
    gender: json["gender"] == null ? null : json["gender"],
    isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
    subscriptionDetails: json["subscriptionDetails"] == null ? null : json["subscriptionDetails"],
  );


  factory LoginUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return LoginUser(
      id: snapshot.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      profileImage: data['profileImage'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      emailAddress: data['emailAddress'] ?? '',
      // auditFields: AuditFields.fromJson(data['auditFields'] ?? {}),
      isDeleted: data['isDeleted'] ?? false,
      gender: data['gender'] ?? '',
    );
  }

}

// class User extends Auditable{
//   final String id;
//   final String name;
//   final String profileImage;
//   final String phoneNumber;
//   final String emailAddress;
//   final AuditFields? auditFields;
//   final bool isDeleted;
//   final SubscriptionDetails? subscriptionDetails;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.profileImage,
//     required this.phoneNumber,
//     required this.emailAddress,
//      this.auditFields,
//     required this.isDeleted,
//     this.subscriptionDetails,
//   });
//
//
//   factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     Map<String, dynamic> data = snapshot.data()!;
//     return User(
//       id: snapshot.id,
//       name: data['name'] ?? '',
//       profileImage: data['profileImage'] ?? '',
//       phoneNumber: data['phoneNumber'] ?? '',
//       emailAddress: data['emailAddress'] ?? '',
//       auditFields: AuditFields.fromJson(data['auditFields'] ?? {}),
//       isDeleted: data['isDeleted'] ?? false,
//     );
//   }
//
// }