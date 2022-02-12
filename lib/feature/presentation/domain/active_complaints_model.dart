import 'dart:convert';
ActiveComplaintsModel activeComplaintsModelFromJson(String str) => ActiveComplaintsModel.fromJson(json.decode(str));
String activeComplaintsModelToJson(ActiveComplaintsModel data) => json.encode(data.toJson());
class ActiveComplaintsModel {
  ActiveComplaintsModel({
      List<Active>? active,}){
    _active = active;
}

  ActiveComplaintsModel.fromJson(dynamic json) {
    if (json['complaints'] != null) {
      _active = [];
      json['complaints'].forEach((v) {
        _active?.add(Active.fromJson(v));
      });
    }
  }
  List<Active>? _active;

  List<Active>? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_active != null) {
      map['active'] = _active?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Active activeFromJson(String str) => Active.fromJson(json.decode(str));
String activeToJson(Active data) => json.encode(data.toJson());
class Active {
  Active({
      int? id, 
      String? zonalId, 
      String? userId, 
      String? isSocietyOwnerFlag, 
      String? complaintName, 
      String? societyId, 
      String? description, 
      String? bpoFlag, 
      String? bpoId, 
      String? status, 
      String? time, 
      String? groundWorkerId, 
      String? cpEngId, 
      String? cpEngFlag, 
      String? teamMemberId, 
      String? superwisorId, 
      String? rating, 
      dynamic beforeimage, 
      String? workduration, 
      dynamic priorityLevel, 
      String? startDate, 
      String? endDate, 
      String? otp, 
      dynamic gwVerifiedFlag, 
      String? isFromSociety, 
      String? price, 
      String? isValid, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _zonalId = zonalId;
    _userId = userId;
    _isSocietyOwnerFlag = isSocietyOwnerFlag;
    _complaintName = complaintName;
    _societyId = societyId;
    _description = description;
    _bpoFlag = bpoFlag;
    _bpoId = bpoId;
    _status = status;
    _time = time;
    _groundWorkerId = groundWorkerId;
    _cpEngId = cpEngId;
    _cpEngFlag = cpEngFlag;
    _teamMemberId = teamMemberId;
    _superwisorId = superwisorId;
    _rating = rating;
    _beforeimage = beforeimage;
    _workduration = workduration;
    _priorityLevel = priorityLevel;
    _startDate = startDate;
    _endDate = endDate;
    _otp = otp;
    _gwVerifiedFlag = gwVerifiedFlag;
    _isFromSociety = isFromSociety;
    _price = price;
    _isValid = isValid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Active.fromJson(dynamic json) {
    _id = json['id'];
    _zonalId = json['zonal_id'];
    _userId = json['user_id'];
    _isSocietyOwnerFlag = json['is_society_owner_flag'];
    _complaintName = json['complaint_name'];
    _societyId = json['society_id'];
    _description = json['description'];
    _bpoFlag = json['bpo_flag'];
    _bpoId = json['bpo_id'];
    _status = json['status'];
    _time = json['time'];
    _groundWorkerId = json['ground_worker_id'];
    _cpEngId = json['cp_eng_id'];
    _cpEngFlag = json['cp_eng_flag'];
    _teamMemberId = json['team_member_id'];
    _superwisorId = json['superwisor_id'];
    _rating = json['rating'];
    _beforeimage = json['beforeimage'];
    _workduration = json['workduration'];
    _priorityLevel = json['priority_level'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _otp = json['otp'];
    _gwVerifiedFlag = json['gw_verified_flag'];
    _isFromSociety = json['is_from_society'];
    _price = json['price'];
    _isValid = json['is_valid'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _zonalId;
  String? _userId;
  String? _isSocietyOwnerFlag;
  String? _complaintName;
  String? _societyId;
  String? _description;
  String? _bpoFlag;
  String? _bpoId;
  String? _status;
  String? _time;
  String? _groundWorkerId;
  String? _cpEngId;
  String? _cpEngFlag;
  String? _teamMemberId;
  String? _superwisorId;
  String? _rating;
  dynamic _beforeimage;
  String? _workduration;
  dynamic _priorityLevel;
  String? _startDate;
  String? _endDate;
  String? _otp;
  dynamic _gwVerifiedFlag;
  String? _isFromSociety;
  String? _price;
  String? _isValid;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get zonalId => _zonalId;
  String? get userId => _userId;
  String? get isSocietyOwnerFlag => _isSocietyOwnerFlag;
  String? get complaintName => _complaintName;
  String? get societyId => _societyId;
  String? get description => _description;
  String? get bpoFlag => _bpoFlag;
  String? get bpoId => _bpoId;
  String? get status => _status;
  String? get time => _time;
  String? get groundWorkerId => _groundWorkerId;
  String? get cpEngId => _cpEngId;
  String? get cpEngFlag => _cpEngFlag;
  String? get teamMemberId => _teamMemberId;
  String? get superwisorId => _superwisorId;
  String? get rating => _rating;
  dynamic get beforeimage => _beforeimage;
  String? get workduration => _workduration;
  dynamic get priorityLevel => _priorityLevel;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get otp => _otp;
  dynamic get gwVerifiedFlag => _gwVerifiedFlag;
  String? get isFromSociety => _isFromSociety;
  String? get price => _price;
  String? get isValid => _isValid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['zonal_id'] = _zonalId;
    map['user_id'] = _userId;
    map['is_society_owner_flag'] = _isSocietyOwnerFlag;
    map['complaint_name'] = _complaintName;
    map['society_id'] = _societyId;
    map['description'] = _description;
    map['bpo_flag'] = _bpoFlag;
    map['bpo_id'] = _bpoId;
    map['status'] = _status;
    map['time'] = _time;
    map['ground_worker_id'] = _groundWorkerId;
    map['cp_eng_id'] = _cpEngId;
    map['cp_eng_flag'] = _cpEngFlag;
    map['team_member_id'] = _teamMemberId;
    map['superwisor_id'] = _superwisorId;
    map['rating'] = _rating;
    map['beforeimage'] = _beforeimage;
    map['workduration'] = _workduration;
    map['priority_level'] = _priorityLevel;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['otp'] = _otp;
    map['gw_verified_flag'] = _gwVerifiedFlag;
    map['is_from_society'] = _isFromSociety;
    map['price'] = _price;
    map['is_valid'] = _isValid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}