import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/models/bottomup_template.dart';
import 'package:ttodolog_fe/models/base_pattern_model.dart';
import 'package:ttodolog_fe/views/pattern_editor_screen.dart';

void main() {
  // ✅ 기본 패턴 데이터 생성
  double initialChestCircumference = 90; // 기본 가슴둘레 설정

  BasePatternModel basePattern =
      BasePatternModel.getBasePatternByChestSize(initialChestCircumference);
  BottomUpTemplate template = BottomUpTemplate(
    basePattern: basePattern,
    chestCircumference: initialChestCircumference,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PatternEditorViewModel(template: template),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PatternEditorScreen(),
    );
  }
}
