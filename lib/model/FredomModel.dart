import 'dart:convert';

class FredomModel {
  late final String country_code;
  late final String name;
  late final String contact_no;
  late final String device_type;
  late final bool is_teacher;
  late final String school;
  late final String school_class;

  FredomModel(
      this.country_code, this.name, this.contact_no, this.device_type, this.is_teacher,this.school,this.school_class);

  toJson() {
    return jsonEncode({
      'country_code': this.country_code,
      'name': this.name,
      'contact_no': this.contact_no,
      'device_type': this.device_type,
      'is_teacher': this.is_teacher,
      'school': this.school,
      'school_class': this.school_class,
    });
  }
}
