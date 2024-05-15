import 'dart:convert';

class MLLModel {
  late final String id;
  late final String name;
  late final String contact_no;
  late final String father_name;
  late final String email;
  late final String city;
  late final String school;
  late final String school_class;
  late final String access_code;

  MLLModel(this.id, this.name, this.contact_no, this.email, this.father_name,
      this.city, this.school, this.school_class, this.access_code);

  toJson() {
    return jsonEncode({
      'id': this.id,
      'name': this.name,
      'contact_no': this.contact_no,
      'father_name': this.father_name,
      'email': this.email,
      'city': this.city,
      'school': this.school,
      'school_class': this.school_class,
      "access_code": this.access_code
    });
  }
}
