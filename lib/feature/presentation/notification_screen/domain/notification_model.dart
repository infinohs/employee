import 'dart:convert';
NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
class NotificationModel {
  NotificationModel({
      bool? success, 
      String? msg, 
      List<Notifications>? notifications,}){
    _success = success;
    _msg = msg;
    _notifications = notifications;
}

  NotificationModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _msg;
  List<Notifications>? _notifications;

  bool? get success => _success;
  String? get msg => _msg;
  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));
String notificationsToJson(Notifications data) => json.encode(data.toJson());
class Notifications {
  Notifications({
      int? id, 
      String? endUserId, 
      String? complaintId, 
      String? status, 
      String? message, 
      String? isSocietyOwnerFlag, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _endUserId = endUserId;
    _complaintId = complaintId;
    _status = status;
    _message = message;
    _isSocietyOwnerFlag = isSocietyOwnerFlag;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Notifications.fromJson(dynamic json) {
    _id = json['id'];
    _endUserId = json['end_user_id'];
    _complaintId = json['complaint_id'];
    _status = json['status'];
    _message = json['message'];
    _isSocietyOwnerFlag = json['is_society_owner_flag'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _endUserId;
  String? _complaintId;
  String? _status;
  String? _message;
  String? _isSocietyOwnerFlag;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get endUserId => _endUserId;
  String? get complaintId => _complaintId;
  String? get status => _status;
  String? get message => _message;
  String? get isSocietyOwnerFlag => _isSocietyOwnerFlag;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['end_user_id'] = _endUserId;
    map['complaint_id'] = _complaintId;
    map['status'] = _status;
    map['message'] = _message;
    map['is_society_owner_flag'] = _isSocietyOwnerFlag;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}