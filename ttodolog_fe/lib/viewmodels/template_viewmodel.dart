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
    BasePatternModel basePattern =
        BasePatternModel.getBasePatternByChestSize(chestCircumference);
    template = BottomUpTemplate(
        basePattern: basePattern, chestCircumference: chestCircumference);
    notifyListeners();
  }
}
