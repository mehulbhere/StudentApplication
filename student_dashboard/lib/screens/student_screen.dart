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
                  final snack = SnackBar(content: Text("New Student Added"));
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                "Academic Year: " + selectedAcademicYear,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                "Class: " + selectedClass,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter Name"),
              onChanged: (value) {
                studentName = value;
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter Fees"),
              onChanged: (value) {
                fees = double.tryParse(value) ?? 0.0;
              },
            ),
          ],
        )),
      ),
    );
  }
}
