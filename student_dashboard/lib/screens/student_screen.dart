import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/models/student.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/home_screen.dart';

class StudentScreen extends StatelessWidget {
  final String selectedAcademicYear;
  final String selectedClass;
  const StudentScreen(
      {super.key,
      required this.selectedAcademicYear,
      required this.selectedClass});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    String studentName = '';
    double fees = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
        actions: [
          IconButton(
              onPressed: () {
                print(studentName +
                    fees.toString() +
                    selectedAcademicYear +
                    selectedClass);
                if (studentName.isNotEmpty && fees >= 0) {
                  studentProvider.addStudent(Student(
                      name: studentName,
                      fees: fees,
                      academicYear: selectedAcademicYear,
                      className: selectedClass));
                }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Enter Student Name"),
            onChanged: (value) {
              studentName = value;
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: "Enter Fees"),
            onChanged: (value) {
              fees = double.tryParse(value) ?? 0.0;
            },
          ),
          Text(selectedAcademicYear),
          Text(selectedClass),
        ],
      )),
    );
  }
}
