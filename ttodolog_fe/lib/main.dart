import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/template_viewmodel.dart';
import 'views/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TemplateViewModel: 템플릿 생성 & 기본 치수 관리
        ChangeNotifierProvider(create: (_) => TemplateViewModel()),
      ],
      child: MaterialApp(
        title: 'Ttodolog Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: AppRoutes.templateInput,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
