import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/template_viewmodel.dart';

class TemplateInputPage extends StatelessWidget {
  const TemplateInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TemplateViewModel>(context);

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
              onChanged: (value) =>
                  viewModel.setChestCircumference(double.tryParse(value) ?? 80),
              decoration: const InputDecoration(hintText: '단위: cm'),
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
                viewModel.generatePattern();
                Navigator.pushNamed(context, '/pattern_editor');
              },
              child: const Text('도안 생성하기'),
            ),
          ],
        ),
      ),
    );
  }
}
