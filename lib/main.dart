import 'package:flutter/material.dart';
import 'package:taskweekfour_todolist/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily To-Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 57, 47, 90),
      ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
