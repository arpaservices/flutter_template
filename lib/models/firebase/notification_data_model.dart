
class NotificationDataModel {
  String? notificationID;
  String? mobileWebMessage;
  String? isMobileRead;
  String? notificationEndDateTime;
  String? notificationStartDateTime;
  String? responseType;
  String? entityType;
  String? entityId;
  String? deviceType;
  String? messageTitle;
  String? notificationType;
  String? notificatiionExpiryDatetime;
  String? deviceKey;
  String? notificationResponseType;
  String? title;
  String? notificationIdentifier;
  String? notificationScreen;
  String? clickaction;

  NotificationDataModel(
      {this.notificationID,
        this.mobileWebMessage,
        this.isMobileRead,
        this.notificationEndDateTime,
        this.notificationStartDateTime,
        this.responseType,
        this.entityType,
        this.entityId,
        this.deviceType,
        this.messageTitle,
        this.notificationType,
        this.notificatiionExpiryDatetime,
        this.deviceKey,
        this.notificationResponseType,
        this.title,
        this.notificationIdentifier,
        this.notificationScreen,
        this.clickaction
      });

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    notificationID = json['NotificationID'];
    mobileWebMessage = json['Mobile_WebMessage'];
    isMobileRead = json['IsMobileRead'];
    notificationEndDateTime = json['NotificationEndDateTime'];
    notificationStartDateTime = json['NotificationStartDateTime'];
    responseType = json['ResponseType'];
    entityType = json['EntityType'];
    entityId = json['EntityId'];
    deviceType = json['DeviceType'];
    messageTitle = json['MessageTitle'];
    notificationType = json['NotificationType'];
    notificatiionExpiryDatetime = json['NotificatiionExpiryDatetime'];
    deviceKey = json['DeviceKey'];
    notificationResponseType = json['NotificationResponseType'];
    title = json['Title'];
    notificationIdentifier = json['NotificationIdentifier'];
    notificationScreen = json['NotificationScreen'];
    clickaction = json['click_action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationID'] = this.notificationID;
    data['Mobile_WebMessage'] = this.mobileWebMessage;
    data['IsMobileRead'] = this.isMobileRead;
    data['NotificationEndDateTime'] = this.notificationEndDateTime;
    data['NotificationStartDateTime'] = this.notificationStartDateTime;
    data['ResponseType'] = this.responseType;
    data['EntityType'] = this.entityType;
    data['EntityId'] = this.entityId;
    data['DeviceType'] = this.deviceType;
    data['MessageTitle'] = this.messageTitle;
    data['NotificationType'] = this.notificationType;
    data['NotificatiionExpiryDatetime'] = this.notificatiionExpiryDatetime;
    data['DeviceKey'] = this.deviceKey;
    data['NotificationResponseType'] = this.notificationResponseType;
    data['Title'] = this.notificationType;
    data['NotificationIdentifier'] = this.notificatiionExpiryDatetime;
    data['NotificationScreen'] = this.deviceKey;
    data['click_action'] = this.notificationResponseType;
    return data;
  }
}

