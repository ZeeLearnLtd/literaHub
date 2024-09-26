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
      'country_code': country_code,
      'name': name,
      'contact_no': contact_no,
      'device_type': device_type,
      'is_teacher': is_teacher,
      'school': school,
      'school_class': school_class,
    });
  }
}
