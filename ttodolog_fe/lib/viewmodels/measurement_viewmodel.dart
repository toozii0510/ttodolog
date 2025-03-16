import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ttodolog_fe/%08viewmodels/template_provider.dart';
import 'package:ttodolog_fe/models/template_model.dart';

class MeasurementViewModel extends StateNotifier<TemplateModel> {
  final Map<String, double> _initialTemplateValues;

  MeasurementViewModel(super.template)
      : _initialTemplateValues = template.toJson();

  double getInitialValue(String key) {
    return _initialTemplateValues[key] ?? 0.0;
  }

  double getMinValue(String key) {
    final initial = getInitialValue(key);
    final allowedRange = {
      "frontNeckDepth": 2.0,
      "armholeDepth": 2.0,
      "sideLength": 5.0,
      "bottomBandHeight": 2.0,
      "neckWidth": 2.0,
      "shoulderWidth": 0.0,
      "chestWidth": 2.0,
      "sleeveLength": 5.0,
      "sleeveBandHeight": 2.0,
      "sleeveWidth": 1.0,
      "wristWidth": 1.0,
    };
    return initial - (allowedRange[key] ?? 0.0);
  }

  double getMaxValue(String key) {
    final initial = getInitialValue(key);
    final allowedRange = {
      "frontNeckDepth": 2.0,
      "armholeDepth": 2.0,
      "sideLength": 5.0,
      "bottomBandHeight": 2.0,
      "neckWidth": 2.0,
      "shoulderWidth": 3.0,
      "chestWidth": 2.0,
      "sleeveLength": 5.0,
      "sleeveBandHeight": 2.0,
      "sleeveWidth": 1.0,
      "wristWidth": 1.0,
    };
    return initial + (allowedRange[key] ?? 0.0);
  }

  void previewMeasurement(String key, double value) {
    state = state.copyWith(
      frontNeckDepth: key == "frontNeckDepth" ? value : state.frontNeckDepth,
      armholeDepth: key == "armholeDepth" ? value : state.armholeDepth,
      sideLength: key == "sideLength" ? value : state.sideLength,
      bottomBandHeight:
          key == "bottomBandHeight" ? value : state.bottomBandHeight,
      neckWidth: key == "neckWidth" ? value : state.neckWidth,
      shoulderWidth: key == "shoulderWidth" ? value : state.shoulderWidth,
      chestWidth: key == "chestWidth" ? value : state.chestWidth,
      sleeveLength: key == "sleeveLength" ? value : state.sleeveLength,
      sleeveBandHeight:
          key == "sleeveBandHeight" ? value : state.sleeveBandHeight,
      sleeveWidth: key == "sleeveWidth" ? value : state.sleeveWidth,
      wristWidth: key == "wristWidth" ? value : state.wristWidth,
    );
  }

  void applyChanges(Map<String, dynamic> newValues) {
    final updatedValues =
        newValues.map((key, value) => MapEntry(key, (value as num).toDouble()));

    state = state.copyWith(
      frontNeckDepth: newValues["frontNeckDepth"] ?? state.frontNeckDepth,
      armholeDepth: newValues["armholeDepth"] ?? state.armholeDepth,
      sideLength: newValues["sideLength"] ?? state.sideLength,
      bottomBandHeight: newValues["bottomBandHeight"] ?? state.bottomBandHeight,
      neckWidth: newValues["neckWidth"] ?? state.neckWidth,
      shoulderWidth: newValues["shoulderWidth"] ?? state.shoulderWidth,
      chestWidth: newValues["chestWidth"] ?? state.chestWidth,
      sleeveLength: newValues["sleeveLength"] ?? state.sleeveLength,
      sleeveBandHeight: newValues["sleeveBandHeight"] ?? state.sleeveBandHeight,
      sleeveWidth: newValues["sleeveWidth"] ?? state.sleeveWidth,
      wristWidth: newValues["wristWidth"] ?? state.wristWidth,
    );
  }
}

final measurementViewModelProvider =
    StateNotifierProvider<MeasurementViewModel, TemplateModel>((ref) {
  final template = ref.watch(templateProviderNotifier);
  if (template == null) throw Exception("템플릿이 선택되지 않았습니다.");
  return MeasurementViewModel(template);
});
