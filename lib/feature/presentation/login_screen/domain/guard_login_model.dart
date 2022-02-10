import 'dart:convert';
GuardLoginModel guardLoginModelFromJson(String str) => GuardLoginModel.fromJson(json.decode(str));
String guardLoginModelToJson(GuardLoginModel data) => json.encode(data.toJson());
class GuardLoginModel {
  GuardLoginModel({
      bool? success, 
      String? message, 
      Security_guard? securityGuard,}){
    _success = success;
    _message = message;
    _securityGuard = securityGuard;
}

  GuardLoginModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _securityGuard = json['security_guard'] != null ? Security_guard.fromJson(json['security_guard']) : null;
  }
  bool? _success;
  String? _message;
  Security_guard? _securityGuard;

  bool? get success => _success;
  String? get message => _message;
  Security_guard? get securityGuard => _securityGuard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_securityGuard != null) {
      map['security_guard'] = _securityGuard?.toJson();
    }
    return map;
  }

}

Security_guard security_guardFromJson(String str) => Security_guard.fromJson(json.decode(str));
String security_guardToJson(Security_guard data) => json.encode(data.toJson());
class Security_guard {
  Security_guard({
      int? id, 
      String? name, 
      String? email, 
      String? password, 
      String? mobile, 
      String? societyId, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _mobile = mobile;
    _societyId = societyId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Security_guard.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _mobile = json['mobile'];
    _societyId = json['society_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _mobile;
  String? _societyId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get mobile => _mobile;
  String? get societyId => _societyId;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['mobile'] = _mobile;
    map['society_id'] = _societyId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}