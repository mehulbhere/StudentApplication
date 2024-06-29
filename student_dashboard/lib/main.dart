import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_dashboard/providers/student_provider.dart';
import 'package:student_dashboard/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StudentProvider())],
      child: MaterialApp(
        title: 'Student Dashboard',
        theme: ThemeData(
          primaryColor: Colors.blue[100],
        ),
        home: HomeScreen(),
      ),
    );
  }
}
