import 'package:flutter/material.dart';
import 'package:TODO/screens/home_screen.dart';

void main() {
  runApp(TODO());
}

class TODO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
