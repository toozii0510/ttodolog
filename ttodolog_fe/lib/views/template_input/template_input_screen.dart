import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/template_viewmodel.dart';
import 'package:ttodolog_fe/views/app_routes.dart';

class TemplateInputScreen extends StatelessWidget {
  const TemplateInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TemplateViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('바텀업 레귤런 니트 템플릿')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('가슴둘레',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double parsed = double.tryParse(value) ?? 80.0;
                // 범위 제한 (60~130)
                if (parsed < 60) parsed = 60;
                if (parsed > 130) parsed = 130;
                viewModel.setChestCircumference(parsed);
              },
              decoration: const InputDecoration(
                hintText: '가슴둘레 (cm), 60~130 사이로 입력',
              ),
            ),
            const SizedBox(height: 16),
            const Text('게이지 (코 / 단)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  viewModel.setStitchGauge(double.tryParse(value) ?? 20),
              decoration: const InputDecoration(hintText: '코 수'),
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  viewModel.setRowGauge(double.tryParse(value) ?? 30),
              decoration: const InputDecoration(hintText: '단 수'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                viewModel.generatePattern(); // ✅ 템플릿 생성
                Navigator.pushNamed(
                    context, AppRoutes.patternEditor); // ✅ 패션 에디터 화면으로 이동
              },
              child: const Text('도안 생성하기'),
            ),
          ],
        ),
      ),
    );
  }
}
