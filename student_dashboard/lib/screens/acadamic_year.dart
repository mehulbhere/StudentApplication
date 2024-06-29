import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/class_screen.dart';

class AcadamicYearScreen extends StatelessWidget {
  const AcadamicYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Academic Year"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: studentProvider.academicYears.isEmpty
            ? Text("No data available. Please add new Academic Year")
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: studentProvider.academicYears.length,
                    itemBuilder: (context, index) {
                      final year = studentProvider.academicYears[index];
                      return ListTile(
                        title: Text(year),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ClassScreen(selectedAcademicYear: year)));
                        },
                      );
                    },
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAcademicYear(context, studentProvider);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddAcademicYear(
      BuildContext context, StudentProvider studentProvider) {
    String year = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add new year:"),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                year = value;
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (year.isNotEmpty) {
                      if (studentProvider.academicYears.contains(year)) {
                        final snack = SnackBar(
                            content: Text("Academic year already exists."));
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      } else {
                        studentProvider.addAcademicYear(year);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'))
            ],
          );
        });
  }
}
