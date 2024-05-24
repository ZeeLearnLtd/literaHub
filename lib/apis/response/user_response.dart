class UserResponse {
  Root? root;

  UserResponse({this.root});

  UserResponse.fromJson(Map<String, dynamic> json) {
    root = json['root'] != null ? new Root.fromJson(json['root']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.root != null) {
      data['root'] = this.root!.toJson();
    }
    return data;
  }
}

class Root {
  Subroot? subroot;

  Root({this.subroot});

  Root.fromJson(Map<String, dynamic> json) {
    subroot =
        json['subroot'] != null ? new Subroot.fromJson(json['subroot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subroot != null) {
      data['subroot'] = this.subroot!.toJson();
    }
    return data;
  }
}

class Subroot {
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
      {this.message,
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
        branchList!.add(new BranchList.fromJson(v));
      });
    }
    }catch(e){
      branchList = <BranchList>[];
      branchList!.add(new BranchList.fromJson(json['branch_list']));
    }
    print('branch list is ${branchList}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['email_id'] = this.emailId;
    data['photopath'] = this.photopath;
    data['contact'] = this.contact;
    data['user_type'] = this.userType;
    data['uid'] = this.uid;
    data['AcdYear'] = this.acdYear;
    data['user_role'] = this.userRole;
    data['SNL_contact'] = this.sNLContact;
    data['SNL_Email'] = this.sNLEmail;
    data['ClassName'] = this.className;
    if (this.branchList != null) {
      data['branch_list'] = this.branchList!.map((v) => v.toJson()).toList();
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
          batchList!.add(new BatchList.fromJson(v));
        });
      }
    }catch(e){
      batchList = <BatchList>[];
      batchList!.add(new BatchList.fromJson(json['batch_list']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['schoolgroup'] = this.schoolgroup;
    if (this.batchList != null) {
      data['batch_list'] = this.batchList!.map((v) => v?.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['batch_id'] = this.batchId;
    return data;
  }
}
