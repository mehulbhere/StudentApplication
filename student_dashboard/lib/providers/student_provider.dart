import 'package:flutter/material.dart';
import 'package:student_dashboard/db/database_helper.dart';
import 'package:student_dashboard/models/student.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  List<String> _academicYears = [];
  Map<String, List<String>> _classes = {};

  List<Student> get students => _students;
  List<String> get academicYears => _academicYears;

  StudentProvider() {
    _loadStudents();
  }
  Future<void> _loadStudents() async {
    _students = await DatabaseHelper.instance.getStudents();
    _academicYears = extractAcademicYears();
    _classes = extractClasses();
    notifyListeners();
  }

  void addStudent(Student student) async {
    final newStudent = Student(
        name: student.name,
        fees: student.fees,
        academicYear: student.academicYear,
        className: student.className);
    await DatabaseHelper.instance.insertStudent(newStudent);
    _students.add(student);
    notifyListeners();
  }

  void addAcademicYear(String year) {
    _academicYears.add(year);
    notifyListeners();
  }

  void addClasses(String year, String className) {
    if (_classes.containsKey(year)) {
      _classes[year]!.add(className);
    } else {
      _classes[year] = [className];
    }
    notifyListeners();
  }

  List<String>? getClassesForYear(String year) {
    return _classes[year];
  }

  Map<String, Map<String, List<Student>>> getSortedStudentList() {
    Map<String, Map<String, List<Student>>> studentList = {};
    for (String year in _academicYears) {
      studentList[year] = {};
    }
    _students.forEach((student) {
      String year = student.academicYear;
      String className = student.className;
      if (!studentList.containsKey(year)) {
        studentList[year] = {};
      }
      if (!studentList[year]!.containsKey(className)) {
        studentList[year]![className] = [];
      }
      studentList[year]![className]!.add(student);
    });
    return studentList;
  }

  List<String> extractAcademicYears() {
    Set<String> yearSet =
        _students.map((student) => student.academicYear).toSet();
    return yearSet.toList();
  }

  Map<String, List<String>> extractClasses() {
    Map<String, List<String>> classesMap = {};

    _students.forEach((student) {
      String year = student.academicYear;
      String className = student.className;

      if (!classesMap.containsKey(year)) {
        classesMap[year] = [];
      }
      if (!classesMap[year]!.contains(className)) {
        classesMap[year]!.add(className);
      }
    });

    return classesMap;
  }
}
