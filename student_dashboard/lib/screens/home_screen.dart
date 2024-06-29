import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/acadamic_year.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final groupedStudents = studentProvider.getSortedStudentList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: groupedStudents.isEmpty
            ? Center(child: Text("No data available. Please add new Student"))
            : ListView.builder(
                itemCount: groupedStudents.length,
                itemBuilder: (context, index) {
                  String academicYear = groupedStudents.keys.elementAt(index);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Batch: $academicYear",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: groupedStudents[academicYear]!.length,
                          itemBuilder: (context, index) {
                            String className = groupedStudents[academicYear]!
                                .keys
                                .elementAt(index);
                            final students =
                                groupedStudents[academicYear]![className]!;
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class: $className",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: students.length,
                                      itemBuilder: (context, index) {
                                        final student = students[index];
                                        return ListTile(
                                          title: Text(student.name),
                                          subtitle: Text(
                                              "Fees: ${student.fees.toString()}"),
                                        );
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ]);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AcadamicYearScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
