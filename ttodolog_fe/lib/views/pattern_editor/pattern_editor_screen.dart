import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/views/pattern_editor/widgets/pattern_editor_sliders.dart';
import '../../widgets/pattern_svg.dart';

class PatternEditorScreen extends StatelessWidget {
  const PatternEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('도안 조정 화면')),
      body: Consumer<PatternEditorViewModel>(
        builder: (context, viewModel, child) {
          return const Column(
            children: [
              // ✅ SVG 패턴 영역 (앞판, 뒷판, 소매)
              Expanded(
                flex: 2, // 전체 화면의 40% 차지
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: PatternSVG(type: "front")), // 앞판
                    Expanded(child: PatternSVG(type: "back")), // 뒷판
                    Expanded(child: PatternSVG(type: "sleeve")), // 소매
                  ],
                ),
              ),

              // ✅ 슬라이더 UI 영역
              // 별도 위젯으로 분리하여 코드 간소화
              Expanded(
                flex: 3, // 전체 화면의 60% 차지
                child: PatternEditorSliders(),
              ),
            ],
          );
        },
      ),
    );
  }
}
