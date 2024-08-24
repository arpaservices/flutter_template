
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/core/app_enums.dart';

class SubscriptionDetails {
  final SubscriptionStatus status;
  final Timestamp startDate;
  final Timestamp endDate;

  SubscriptionDetails({
    required this.startDate,
    required this.status,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "status": status,
    "endDate": endDate,
  };

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => SubscriptionDetails(
    status: json["status"] == null ? null : json["status"],
    startDate: json["startDate"] == null ? null : json["startDate"],
    endDate: json["endDate"] == null ? null : json["endDate"],
  );
}
