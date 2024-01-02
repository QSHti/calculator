import 'package:flutter/material.dart';
import 'ui/calculator.dart';
import 'ui/converter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
      home: CalculatorPage(),
      routes: {
        '/converter': (context) => ConverterPage(),
      },
    );
  }
}
