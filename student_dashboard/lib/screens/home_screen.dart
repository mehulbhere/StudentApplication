import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/acadamic_year.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageControllerYear;
  late PageController _pageControllerClass;
  int selectedYearIndex = 0;
  int selectedClassIndex = 0;
  @override
  void initState() {
    _pageControllerClass = PageController();
    _pageControllerYear = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageControllerClass.dispose();
    _pageControllerYear.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final groupedStudents = studentProvider.getSortedStudentList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: groupedStudents.isEmpty
              ? Center(child: Text("No data available. Please add new Student"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Year:"),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: groupedStudents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedYearIndex = index;
                                selectedClassIndex = 0;
                              });
                              _pageControllerYear.animateToPage(index,
                                  curve: Curves.ease,
                                  duration: Duration(milliseconds: 30));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Chip(
                                side: selectedYearIndex == index
                                    ? BorderSide.none
                                    : BorderSide(width: 0.4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: selectedYearIndex == index
                                    ? Colors.blue[100]
                                    : Colors.transparent,
                                label:
                                    Text(groupedStudents.keys.elementAt(index)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageControllerYear,
                        itemCount: groupedStudents.length,
                        itemBuilder: (context, index) {
                          String academicYear =
                              groupedStudents.keys.elementAt(index);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Select Class:"),
                              Container(
                                height: 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      groupedStudents[academicYear]!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedClassIndex = index;
                                        });
                                        _pageControllerClass.animateToPage(
                                            index,
                                            curve: Curves.ease,
                                            duration:
                                                Duration(milliseconds: 30));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Chip(
                                          side: selectedClassIndex == index
                                              ? BorderSide.none
                                              : BorderSide(width: 0.4),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor:
                                              selectedClassIndex == index
                                                  ? Colors.blue[100]
                                                  : Colors.transparent,
                                          label: Text(
                                              groupedStudents[academicYear]!
                                                  .keys
                                                  .elementAt(index)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: PageView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: _pageControllerClass,
                                  itemCount:
                                      groupedStudents[academicYear]!.length,
                                  itemBuilder: (context, index) {
                                    String className =
                                        groupedStudents[academicYear]!
                                            .keys
                                            .elementAt(index);
                                    final students = groupedStudents[
                                        academicYear]![className]!;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Student List:",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Text(
                                          "Year: " +
                                              academicYear +
                                              ", Class: " +
                                              className,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: students.length,
                                            itemBuilder: (context, index) {
                                              final student = students[index];
                                              return ListTile(
                                                title: Text(student.name),
                                                subtitle: Text(
                                                    "Fees: ${student.fees.toString()}"),
                                              );
                                            }),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AcadamicYearScreen()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
