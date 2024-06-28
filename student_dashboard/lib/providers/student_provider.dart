import 'package:flutter/material.dart';
import 'package:student_dashboard/models/Student.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  List<String> _academicYears = ['2020','2021','2022'];
  Map<String, List<String>> _classes = {};

  List<Student> get students => _students;
  List<String> get academicYears => _academicYears;

  void addStudent(Student student){
    _students.add(student);
    notifyListeners();
  }
  void addAcademicYear(String year){
    _academicYears.add(year);
    notifyListeners();
  }
  void addClasses(String year, String className){
    if(_classes.containsKey(year)){
      _classes[year]!.add(className);
    }
    else{
      _classes[year] = [className];
    }
    notifyListeners();
  }
  List<String>? getClassesForYear(String year){
    return _classes[year];
  }

  Map<String,Map<String,List<Student>>> getSortedStudentList(){
    Map<String,Map<String,List<Student>>> studentList = {};
    for (String year in _academicYears){
      studentList[year] = {};
    }
    _students.forEach((student){
      String year = student.academicYear;
      String className = student.className;
      if(!studentList.containsKey(year)){
        studentList[year] = {};
      }
      if(!studentList[year]!.containsKey(className)){
        studentList[year]![className] = [];
      }
      studentList[year]![className]!.add(student);
    });
    return studentList;
  }
}