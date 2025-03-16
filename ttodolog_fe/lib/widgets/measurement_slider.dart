import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ttodolog_fe/%08viewmodels/measurement_viewmodel.dart';
import 'package:ttodolog_fe/models/template_model.dart';

class MeasurementSliders extends ConsumerWidget {
  const MeasurementSliders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final measurementVM = ref.watch(measurementViewModelProvider.notifier);
    final measurementState = ref.watch(measurementViewModelProvider);

    // 몸판 관련 항목
    const bodyMeasurementKeys = [
      "frontNeckDepth",
      "armholeDepth",
      "sideLength",
      "bottomBandHeight",
      "neckWidth",
      "shoulderWidth",
      "chestWidth",
    ];

    // 소매 관련 항목
    const sleeveMeasurementKeys = [
      "sleeveLength",
      "sleeveBandHeight",
      "sleeveWidth",
      "wristWidth"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "치수 조정",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        /// **몸판/소매를 가로 배치, 내부는 세로 정렬**
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **몸판 관련 슬라이더**
            Expanded(
              child: _buildMeasurementGroup(
                title: "몸판 치수",
                keys: bodyMeasurementKeys,
                measurementVM: measurementVM,
                measurementState: measurementState,
              ),
            ),

            /// **소매 관련 슬라이더**
            Expanded(
              child: _buildMeasurementGroup(
                title: "소매 치수",
                keys: sleeveMeasurementKeys,
                measurementVM: measurementVM,
                measurementState: measurementState,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// **🚀 `Column` 내부에 세로로 슬라이더 정렬 + `Card` 적용**
  Widget _buildMeasurementGroup({
    required String title,
    required List<String> keys,
    required MeasurementViewModel measurementVM,
    required TemplateModel measurementState,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (var key in keys)
              _buildSlider(key, measurementVM, measurementState),
          ],
        ),
      ),
    );
  }

  /// **📌 슬라이더 UI (개선된 버전)**
  Widget _buildSlider(String key, MeasurementViewModel measurementVM,
      TemplateModel measurementState) {
    double value = measurementState.toJson()[key]!;
    double min = measurementVM.getMinValue(key);
    double max = measurementVM.getMaxValue(key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getLabel(key),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${min.toStringAsFixed(1)} cm",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${value.toStringAsFixed(2)} cm",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "${max.toStringAsFixed(1)} cm",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          onChanged: (newValue) {
            measurementVM.previewMeasurement(key, newValue);
          },
          activeColor: Colors.blue,
          inactiveColor: Colors.grey.shade300,
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  /// **📌 슬라이더 라벨 변환 (한글 표시)**
  String _getLabel(String key) {
    const labelMap = {
      "frontNeckDepth": "앞목 깊이",
      "armholeDepth": "진동 길이",
      "sideLength": "옆 길이",
      "bottomBandHeight": "아래 고무단 길이",
      "neckWidth": "목 너비",
      "shoulderWidth": "어깨 너비",
      "chestWidth": "가슴 너비",
      "sleeveLength": "소매 길이",
      "sleeveBandHeight": "소매 고무단 높이",
      "sleeveWidth": "소매 너비",
      "wristWidth": "손목 너비",
    };

    return labelMap[key] ?? key;
  }
}
