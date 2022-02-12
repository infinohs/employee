import 'dart:convert';
ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));
String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());
class ServicesModel {
  ServicesModel({
      List<Services>? services, 
      bool? success,}){
    _services = services;
    _success = success;
}

  ServicesModel.fromJson(dynamic json) {
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<Services>? _services;
  bool? _success;

  List<Services>? get services => _services;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));
String servicesToJson(Services data) => json.encode(data.toJson());
class Services {
  Services({
      int? id, 
      String? servicesName, 
      String? igst, 
      String? sgst, 
      String? cgst, 
      String? price, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _servicesName = servicesName;
    _igst = igst;
    _sgst = sgst;
    _cgst = cgst;
    _price = price;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _servicesName = json['services_name'];
    _igst = json['igst'];
    _sgst = json['sgst'];
    _cgst = json['cgst'];
    _price = json['price'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _servicesName;
  String? _igst;
  String? _sgst;
  String? _cgst;
  String? _price;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get servicesName => _servicesName;
  String? get igst => _igst;
  String? get sgst => _sgst;
  String? get cgst => _cgst;
  String? get price => _price;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['services_name'] = _servicesName;
    map['igst'] = _igst;
    map['sgst'] = _sgst;
    map['cgst'] = _cgst;
    map['price'] = _price;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}