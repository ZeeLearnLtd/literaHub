import 'dart:convert';

class MLLModel {
  late final String id;
  late final String userName;
  late final String name;
  late final String contact_no;
  late final String father_name;
  late final String email;
  late final String city;
  late final String school;
  late final String school_class;
  late final String access_code;

  MLLModel(this.id, this.name,this.userName, this.contact_no, this.email, this.father_name,
      this.city, this.school, this.school_class, this.access_code);

  toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'user_name': userName,
      'contact_no': contact_no,
      'father_name': father_name,
      'email': email,
      'city': city,
      'school': school,
      'school_class': school_class,
      "access_code": access_code
    });
  }
}
