import 'dart:convert';
FlatsModel flatsModelFromJson(String str) => FlatsModel.fromJson(json.decode(str));
String flatsModelToJson(FlatsModel data) => json.encode(data.toJson());
class FlatsModel {
  FlatsModel({
      bool? success, 
      String? message, 
      List<Flats>? flats,}){
    _success = success;
    _message = message;
    _flats = flats;
}

  FlatsModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['flats'] != null) {
      _flats = [];
      json['flats'].forEach((v) {
        _flats?.add(Flats.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Flats>? _flats;

  bool? get success => _success;
  String? get message => _message;
  List<Flats>? get flats => _flats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_flats != null) {
      map['flats'] = _flats?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Flats flatsFromJson(String str) => Flats.fromJson(json.decode(str));
String flatsToJson(Flats data) => json.encode(data.toJson());
class Flats {
  Flats({
      int? id, 
      String? societyId, 
      String? username, 
      String? password, 
      String? email, 
      String? mobile, 
      String? profileImg, 
      String? cityId, 
      String? fullName, 
      dynamic contratStatus, 
      String? isOwner, 
      dynamic deviceId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _societyId = societyId;
    _username = username;
    _password = password;
    _email = email;
    _mobile = mobile;
    _profileImg = profileImg;
    _cityId = cityId;
    _fullName = fullName;
    _contratStatus = contratStatus;
    _isOwner = isOwner;
    _deviceId = deviceId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Flats.fromJson(dynamic json) {
    _id = json['id'];
    _societyId = json['society_id'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _profileImg = json['profile_img'];
    _cityId = json['city_id'];
    _fullName = json['full_name'];
    _contratStatus = json['contrat_status'];
    _isOwner = json['is_owner'];
    _deviceId = json['device_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _societyId;
  String? _username;
  String? _password;
  String? _email;
  String? _mobile;
  String? _profileImg;
  String? _cityId;
  String? _fullName;
  dynamic _contratStatus;
  String? _isOwner;
  dynamic _deviceId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get societyId => _societyId;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get profileImg => _profileImg;
  String? get cityId => _cityId;
  String? get fullName => _fullName;
  dynamic get contratStatus => _contratStatus;
  String? get isOwner => _isOwner;
  dynamic get deviceId => _deviceId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['society_id'] = _societyId;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['profile_img'] = _profileImg;
    map['city_id'] = _cityId;
    map['full_name'] = _fullName;
    map['contrat_status'] = _contratStatus;
    map['is_owner'] = _isOwner;
    map['device_id'] = _deviceId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}