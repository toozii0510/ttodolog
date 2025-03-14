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

    const measurementKeys = [
      "frontNeckDepth",
      "armholeDepth",
      "sideLength",
      "bottomBandHeight",
      "neckWidth",
      "shoulderWidth",
      "chestWidth",
      "sleeveLength",
      "sleeveBandHeight",
      "sleeveWidth",
      "wristWidth"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var key in measurementKeys)
          _buildSlider(key, measurementVM, measurementState),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () =>
              measurementVM.applyChanges(measurementState.toJson()),
          child: const Text("도안 생성하기"),
        ),
      ],
    );
  }

  Widget _buildSlider(String key, MeasurementViewModel measurementVM,
      TemplateModel measurementState) {
    double value = measurementState.toJson()[key]!;
    double min = measurementVM.getMinValue(key);
    double max = measurementVM.getMaxValue(key);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "$key (${min.toStringAsFixed(1)} - ${max.toStringAsFixed(1)} cm)"),
              Text("${value.toStringAsFixed(2)} cm",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            onChanged: (newValue) {
              measurementVM.previewMeasurement(key, newValue);
            },
          ),
        ],
      ),
    );
  }
}
