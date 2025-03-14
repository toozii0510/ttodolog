import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ttodolog_fe/%08viewmodels/template_provider.dart';
import '../router/app_router.dart';

class TemplateSelectionScreen extends ConsumerWidget {
  const TemplateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("템플릿 선택")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(templateProviderNotifier.notifier).updateSelection(
                      knittingMethod: "bottom_up",
                      category: "knit",
                      fitType: "regular_fit",
                    );
                context.go(AppRoutes.basicInfoInput);
              },
              child: const Text("바텀업 니트 선택"),
            ),
          ],
        ),
      ),
    );
  }
}
