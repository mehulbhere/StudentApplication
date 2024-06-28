import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/student_screen.dart';

class ClassScreen extends StatelessWidget {
  final String selectedAcademicYear;
  const ClassScreen({super.key, required this.selectedAcademicYear});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Classes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Classes for $selectedAcademicYear:"),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: studentProvider
                      .getClassesForYear(selectedAcademicYear)
                      ?.length ??
                  0,
              itemBuilder: (context, index) {
                final className = studentProvider
                    .getClassesForYear(selectedAcademicYear)![index];
                return ListTile(
                  title: Text(className),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentScreen(
                            selectedAcademicYear: selectedAcademicYear,
                            selectedClass: className)));
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddClass(context, studentProvider);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddClass(BuildContext context, StudentProvider studentProvider) {
    String newClass = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add new class"),
            content: TextField(
              onChanged: (value) {
                newClass = value;
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (newClass.isNotEmpty) {
                      studentProvider.addClasses(
                          selectedAcademicYear, newClass);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"))
            ],
          );
        });
  }
}
