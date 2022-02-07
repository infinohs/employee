import 'dart:convert';
Profile_update_model profile_update_modelFromJson(String str) => Profile_update_model.fromJson(json.decode(str));
String profile_update_modelToJson(Profile_update_model data) => json.encode(data.toJson());
class Profile_update_model {
  Profile_update_model({
      bool? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  Profile_update_model.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  bool? _success;
  String? _message;

  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}