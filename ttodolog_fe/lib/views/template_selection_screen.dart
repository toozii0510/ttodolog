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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **✅ 상단 타이틀 및 설명**
            const SizedBox(height: 20),
            const Text(
              "도안 템플릿을 선택하세요",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "사용할 니트 도안 템플릿을 선택하면 다음 단계에서 상세 정보를 입력할 수 있습니다.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            /// **✅ 템플릿 선택 카드**
            Expanded(
              child: ListView(
                children: [
                  _buildTemplateCard(
                    context: context,
                    ref: ref,
                    title: "바텀업 니트",
                    description: "전통적인 바텀업 방식으로 니트를 제작합니다.",
                    knittingMethod: "bottom_up",
                    category: "knit",
                    fitType: "regular_fit",
                  ),
                  // 이후 다른 템플릿을 추가 가능
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **📌 템플릿 선택 카드 위젯**
  Widget _buildTemplateCard({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String description,
    required String knittingMethod,
    required String category,
    required String fitType,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(templateProviderNotifier.notifier).updateSelection(
              knittingMethod: knittingMethod,
              category: category,
              fitType: fitType,
            );
        context.go(AppRoutes.basicInfoInput);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              /// **✅ 아이콘**
              const Icon(Icons.checkroom, size: 50, color: Colors.blue),
              const SizedBox(width: 20),

              /// **✅ 텍스트 정보**
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              /// **✅ 선택 버튼**
              OutlinedButton(
                onPressed: () {
                  ref.read(templateProviderNotifier.notifier).updateSelection(
                        knittingMethod: knittingMethod,
                        category: category,
                        fitType: fitType,
                      );
                  context.go(AppRoutes.basicInfoInput);
                },
                child: const Text("선택"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
