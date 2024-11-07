import 'dart:convert';

class GetFradomDeepLink {
  late String name;
  late String grade;
  late String schoolCode;
  late String contactNo;
  late String deviceType;
  late String description;
  late String schoolClass;
  late String countryCode;
  late String email;
  late String age;
  late String userType;
  late List<Siblings> siblings;
  late List<SchoolClass> schoolClassList;

  GetFradomDeepLink(
      {required this.name,
        required this.grade,
        required this.schoolCode,
        required this.contactNo,
        required this.deviceType,
        required this.description,
        required this.schoolClass,
        required this.countryCode,
        required this.email,
        required this.age,
        required this.userType,
        required this.schoolClassList,
        required this.siblings});

  GetFradomDeepLink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    grade = json['grade'];
    schoolCode = json['school_code'];
    contactNo = json['contact_no'];
    deviceType = json['device_type'];
    description = json['description'];
    schoolClass = json['school_class'];
    countryCode = json['country_code'];
    email = json['email'];
    userType = json['userType'];
    age = json['age'];
    if (json['siblings'] != null) {
      siblings = <Siblings>[];
      json['siblings'].forEach((v) {
        siblings.add(Siblings.fromJson(v));
      });
    }
  }

  toJson() {
    if(userType=='Teacher'){
      return jsonEncode({
        'name': name,
        'grade': grade,
        'school_code': schoolCode,
        'contact_no': contactNo,
        'device_type': deviceType,
        'description': description,
        'school_class':schoolClassList.map((v) => schoolClass).toList(),
        //'country_code': this.countryCode,
        //'email': this.email,
        //'age': this.age,
        'siblings': siblings.map((v) => v.toJson()).toList(),
      });
    }else {
      return jsonEncode({
        'name': name,
        'grade': grade,
        'school_code': schoolCode,
        'contact_no': contactNo,
        'device_type': deviceType,
        'description': description,
        'school_class': schoolClass,
        //'country_code': this.countryCode,
        //'email': this.email,
        //'age': this.age,
        'siblings': siblings.map((v) => v.toJson()).toList(),
      });
    }
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['grade'] = grade;
    data['school_code'] = schoolCode;
    data['contact_no'] = contactNo;
    data['device_type'] = deviceType;
    data['description'] = description;
    data['school_class'] = schoolClass;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['age'] = age;
    /*if (this.siblings != null) {
      data['siblings'] = this.siblings!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Siblings {
  String? name;
  String? grade;
  String? schoolCode;
  String? schoolClass;

  Siblings({this.name, this.grade, this.schoolCode, this.schoolClass});

  Siblings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    grade = json['grade'];
    schoolCode = json['school_code'];
    schoolClass = json['school_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['grade'] = grade;
    data['school_code'] = schoolCode;
    data['school_class'] = schoolClass;
    return data;
  }


}

class SchoolClass {
  String? schoolClass;

  SchoolClass({this.schoolClass});

  SchoolClass.fromJson(Map<String, dynamic> json) {
    schoolClass = json['schoolClass'];
  }

  Map<String, dynamic> toSchoolClass(String schoolClass) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['school_class'] =schoolClass;
    return data;
  }
}