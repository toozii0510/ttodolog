import 'package:flutter/material.dart';
import 'package:ttodolog_fe/views/pattern_adjust.dart';
import 'package:ttodolog_fe/views/template_input.dart';

void main() {
  runApp(const KnitApp());
}

class KnitApp extends StatelessWidget {
  const KnitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '뜨도록 - 태블릿 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MultiPatternAdjuster(),
    );
  }
}
