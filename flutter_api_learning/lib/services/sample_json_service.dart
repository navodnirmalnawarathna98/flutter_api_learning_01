import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/student.dart';

class SampleJsonService {
  Future<Student> loadStudent() async {
    final jsonString = await rootBundle.loadString(
      'assets/sample_student.json',
    );

    // 1. Decode as a List instead of a Map
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

    // 2. Map the first item in the list to a Student object
    return Student.fromJson(jsonList.first as Map<String, dynamic>);
  }
}