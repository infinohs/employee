import 'dart:convert';
LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      int? id, 
      String? cityId, 
      String? username, 
      String? password, 
      String? email, 
      String? mobile, 
      String? profileImg, 
      String? pin, 
      String? chanelPartnerEngineerFlag, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _cityId = cityId;
    _username = username;
    _password = password;
    _email = email;
    _mobile = mobile;
    _profileImg = profileImg;
    _pin = pin;
    _chanelPartnerEngineerFlag = chanelPartnerEngineerFlag;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LoginModel.fromJson(dynamic json) {
    _id = json['id'];
    _cityId = json['city_id'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _profileImg = json['profile_img'];
    _pin = json['pin'];
    _chanelPartnerEngineerFlag = json['chanel_partner_engineer_flag'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _cityId;
  String? _username;
  String? _password;
  String? _email;
  String? _mobile;
  String? _profileImg;
  String? _pin;
  String? _chanelPartnerEngineerFlag;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get cityId => _cityId;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get profileImg => _profileImg;
  String? get pin => _pin;
  String? get chanelPartnerEngineerFlag => _chanelPartnerEngineerFlag;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city_id'] = _cityId;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['profile_img'] = _profileImg;
    map['pin'] = _pin;
    map['chanel_partner_engineer_flag'] = _chanelPartnerEngineerFlag;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}