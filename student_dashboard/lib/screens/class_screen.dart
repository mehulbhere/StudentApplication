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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: studentProvider.getClassesForYear(selectedAcademicYear) == null
            ? Text("No data available")
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
        backgroundColor: Theme.of(context).primaryColor,
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
                      if (studentProvider
                                  .getClassesForYear(selectedAcademicYear) !=
                              null &&
                          studentProvider
                              .getClassesForYear(selectedAcademicYear)!
                              .contains(newClass)) {
                        final snack =
                            SnackBar(content: Text("Class already exists."));
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      } else {
                        studentProvider.addClasses(
                            selectedAcademicYear, newClass);
                        print("added" + newClass);
                      }
                    }
                    print("addddd");
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"))
            ],
          );
        });
  }
}
