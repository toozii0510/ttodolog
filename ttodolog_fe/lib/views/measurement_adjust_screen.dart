import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ttodolog_fe/%08viewmodels/measurement_viewmodel.dart';
import 'package:ttodolog_fe/%08viewmodels/template_provider.dart';
import 'package:ttodolog_fe/widgets/measurement_slider.dart';
import '../widgets/pattern_svg.dart';

class MeasurementAdjustScreen extends ConsumerWidget {
  const MeasurementAdjustScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(templateProviderNotifier);

    if (template == null) {
      return const Scaffold(
        body: Center(child: Text("오류: 템플릿이 선택되지 않았습니다.")),
      );
    }

    final measurementVM = ref.watch(measurementViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("세부 치수 조정")),
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: PatternSVG(type: "front")),
                Expanded(child: PatternSVG(type: "back")),
                Expanded(child: PatternSVG(type: "sleeve")),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MeasurementSliders(),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                measurementVM.applyChanges(measurementVM.state.toJson().map(
                    (key, value) => MapEntry(key, (value as num).toDouble())));

                /// **🚀 선택한 템플릿의 방식(top_down or bottom_up)에 따라 화면 이동**
                if (template.knittingMethod == "top_down") {
                  context.go('/top_down_layout');
                } else {
                  context.go('/bottom_up_layout');
                }
              },
              child: const Text("도안 생성하기"),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
