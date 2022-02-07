import 'dart:convert';
DetailModel detailModelFromJson(String str) => DetailModel.fromJson(json.decode(str));
String detailModelToJson(DetailModel data) => json.encode(data.toJson());
class DetailModel {
  DetailModel({
      bool? success, 
      String? message, 
      User? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  DetailModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _success;
  String? _message;
  User? _user;

  bool? get success => _success;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}