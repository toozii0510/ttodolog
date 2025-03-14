import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ttodolog_fe/%08viewmodels/template_provider.dart';
import '../router/app_router.dart';

class BasicInfoScreen extends ConsumerStatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends ConsumerState<BasicInfoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("기본 정보 입력")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("가슴둘레(cm)를 입력하세요"),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "예: 90",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final chestCircumference = double.tryParse(_controller.text);
                if (chestCircumference != null) {
                  ref
                      .read(templateProviderNotifier.notifier)
                      .updateChestCircumference(chestCircumference);
                  context.go(AppRoutes.measurementAdjust);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("올바른 숫자를 입력하세요.")),
                  );
                }
              },
              child: const Text("다음"),
            ),
          ],
        ),
      ),
    );
  }
}
