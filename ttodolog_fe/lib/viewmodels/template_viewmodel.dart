import 'package:flutter/material.dart';
import 'package:ttodolog_fe/models/bottomup_template.dart';
import 'package:ttodolog_fe/models/base_pattern_model.dart';

class TemplateViewModel extends ChangeNotifier {
  double chestCircumference = 80;
  double stitchGauge = 20;
  double rowGauge = 30;
  BottomUpTemplate? template;

  void setChestCircumference(double value) {
    chestCircumference = value;
    notifyListeners();
  }

  void setStitchGauge(double value) {
    stitchGauge = value;
    notifyListeners();
  }

  void setRowGauge(double value) {
    rowGauge = value;
    notifyListeners();
  }

  void generatePattern() {
    // BasePatternModel에서 가슴둘레에 맞는 기본 패턴 가져오기
    final basePattern =
        BasePatternModel.getBasePatternByChestSize(chestCircumference);

    // BottomUpTemplate 생성
    template = BottomUpTemplate(
      basePattern: basePattern,
      chestCircumference: chestCircumference,
    );

    // 나중에 stitchGauge, rowGauge도 템플릿에 반영 가능
    // template.setGauge(stitchGauge, rowGauge) 등...

    notifyListeners();
  }
}
