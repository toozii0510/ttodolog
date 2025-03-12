import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'template_input/template_input_screen.dart';
import 'pattern_editor/pattern_editor_screen.dart';

// ViewModels

import 'package:ttodolog_fe/viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/viewmodels/template_viewmodel.dart';
import '../../models/bottomup_template.dart';

class AppRoutes {
  static const templateInput = '/';
  static const patternEditor = '/pattern_editor';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case templateInput:
        return MaterialPageRoute(builder: (_) => const TemplateInputScreen());

      case patternEditor:
        // TemplateViewModel 가져오기 (현재 context)
        // 주의: onGenerateRoute는 MaterialApp 위이므로 context가 최상위 Provider를 찾을 수 있어야 함
        return MaterialPageRoute(builder: (context) {
          final templateVM =
              Provider.of<TemplateViewModel>(context, listen: false);
          final template = templateVM.template;

          if (template == null) {
            // 아직 generatePattern() 안했을 때
            return const Scaffold(
              body: Center(child: Text('템플릿이 생성되지 않았습니다.')),
            );
          }

          // PatternEditorViewModel 주입
          return ChangeNotifierProvider(
            create: (_) => PatternEditorViewModel(template: template),
            child: const PatternEditorScreen(),
          );
        });

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('404: 페이지를 찾을 수 없습니다.')),
                ));
    }
  }
}
