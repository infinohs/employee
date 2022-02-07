import 'dart:convert';
SocietyListModel SocietyListModelFromJson(String str) => SocietyListModel.fromJson(json.decode(str));
String SocietyListModelToJson(SocietyListModel data) => json.encode(data.toJson());
class SocietyListModel {
  SocietyListModel({
      int? id, 
      String? societyName, 
      String? cityId, 
      String? addressLine1, 
      String? addressLine2, 
      String? zip, 
      String? servicesId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _societyName = societyName;
    _cityId = cityId;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _zip = zip;
    _servicesId = servicesId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  SocietyListModel.fromJson(dynamic json) {
    _id = json['id'];
    _societyName = json['society_name'];
    _cityId = json['city_id'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _zip = json['zip'];
    _servicesId = json['services_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _societyName;
  String? _cityId;
  String? _addressLine1;
  String? _addressLine2;
  String? _zip;
  String? _servicesId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get societyName => _societyName;
  String? get cityId => _cityId;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get zip => _zip;
  String? get servicesId => _servicesId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['society_name'] = _societyName;
    map['city_id'] = _cityId;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['zip'] = _zip;
    map['services_id'] = _servicesId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}