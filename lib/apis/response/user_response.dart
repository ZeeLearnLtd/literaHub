
import 'dart:convert';

UserResponse loginRespFromJson(String str) => UserResponse.fromJson(json.decode(str));

String loginRespToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  Root? root;

  UserResponse({this.root});

  UserResponse.fromJson(Map<String, dynamic> json) {
    root = json['root'] != null ? Root.fromJson(json['root']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (root != null) {
      data['root'] = root!.toJson();
    }
    return data;
  }
}

class Root {
  Subroot? subroot;

  Root({this.subroot});

  Root.fromJson(Map<String, dynamic> json) {
    subroot =
        json['subroot'] != null ? Subroot.fromJson(json['subroot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subroot != null) {
      data['subroot'] = subroot!.toJson();
    }
    return data;
  }
}

class Subroot {
  String isfreedomaccess='';
  String freedom_code='';
  String? message;
  String? userId;
  String? userName;
  String? emailId;
  String? photopath;
  String? contact;
  String? userType;
  String? uid;
  String? acdYear;
  String? userRole;
  String? sNLContact;
  String? sNLEmail;
  String? className;
  List<BranchList>? branchList;

  Subroot(
      {
      required this.isfreedomaccess,
      required this.freedom_code,
      this.message,
      this.userId,
      this.userName,
      this.emailId,
      this.photopath,
      this.contact,
      this.userType,
      this.uid,
      this.acdYear,
      this.userRole,
      this.sNLContact,
      this.sNLEmail,
      this.className,
      this.branchList});

  Subroot.fromJson(Map<String, dynamic> json) {
    isfreedomaccess = json.containsKey('isfreedomaccess') ? json['isfreedomaccess'] ?? '' : '';
    freedom_code =  json.containsKey('freedom_code') ? json['freedom_code'] ?? '' : '';
    print('isfreedomaccess $isfreedomaccess');
    message = json['message'] ?? '';
    userId = json['user_id'] ?? '';
    userName = json['user_name'] ?? '';
    emailId = json['email_id'] ?? '';
    photopath = json['photopath'] ?? '';
    contact = json['contact'] ?? '';
    userType = json['user_type'] ?? '';
    uid = json['uid'] ?? '';
    print('UID s====');
    acdYear = json['AcdYear'] ?? '';
    userRole = json['user_role'] ?? '';
    print('UID s====82');
    sNLContact = json['SNL_contact'] ?? '';
    sNLEmail = json['SNL_Email'] ?? '';
    print('UID s====85');
    className = json['ClassName'] ?? '';
    print('UID s====87');
    try{
    if (json['branch_list'] != null) {
      branchList = <BranchList>[];
      json['branch_list'].forEach((v) {
        branchList!.add(BranchList.fromJson(v));
      });
    }
    }catch(e){
      branchList = <BranchList>[];
      branchList!.add(BranchList.fromJson(json['branch_list']));
    }
    print('branch list is $branchList');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['email_id'] = emailId;
    data['photopath'] = photopath;
    data['contact'] = contact;
    data['user_type'] = userType;
    data['uid'] = uid;
    data['AcdYear'] = acdYear;
    data['user_role'] = userRole;
    data['SNL_contact'] = sNLContact;
    data['SNL_Email'] = sNLEmail;
    data['ClassName'] = className;
    if (branchList != null) {
      data['branch_list'] = branchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchList {
  String? branchId;
  String? branchName;
  String? schoolgroup;
  List<BatchList?>? batchList;

  BranchList(
      {this.branchId, this.branchName, this.schoolgroup, this.batchList});

  BranchList.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    schoolgroup = json['schoolgroup'] ;

    try{
      if (json['batch_list'] != null) {
        batchList = <BatchList>[];
        json['batch_list'].forEach((v) {
          batchList!.add(BatchList.fromJson(v));
        });
      }
    }catch(e){
      batchList = <BatchList>[];
      batchList!.add(BatchList.fromJson(json['batch_list']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['schoolgroup'] = schoolgroup;
    if (batchList != null) {
      data['batch_list'] = batchList!.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class BatchList {
  String? batchName;
  String? batchId;

  BatchList({this.batchName, this.batchId});

  BatchList.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    batchId = json['batch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batch_name'] = batchName;
    data['batch_id'] = batchId;
    return data;
  }
}
