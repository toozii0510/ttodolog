import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final measurementVM = ref.watch(measurementViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("세부 치수 조정")),
      body: const Column(
        children: [
          Expanded(
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
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MeasurementSliders(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
