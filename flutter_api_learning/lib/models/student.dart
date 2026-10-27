import 'dart:convert';

class Student {
  final int id;
  final String name;
  final String course;
  final String email;
  final bool active;

  const Student({
    required this.id,
    required this.name,
    required this.course,
    required this.email,
    required this.active,
  });

  factory Student.fromJson(Map<String,dynamic> json){
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      course: json['course'] as String,
      email: json['email'] as String,
      active: json['active'] as bool,
    );
  }
}