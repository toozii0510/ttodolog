import 'package:flutter/material.dart';
import 'package:ttodolog_fe/models/bottomup_template.dart';

class PatternEditorViewModel extends ChangeNotifier {
  BottomUpTemplate template;

  PatternEditorViewModel({required this.template});

  double get frontNeckDepth => template.frontNeckDepth;
  double get armholeDepth => template.armholeDepth;
  double get sideLength => template.sideLength;
  double get sleeveLength => template.sleeveLength;

  void setFrontNeckDepth(double value) {
    template.frontNeckDepth = value;
    notifyListeners();
  }

  void setArmholeDepth(double value) {
    template.armholeDepth = value;
    notifyListeners();
  }

  void setSideLength(double value) {
    template.sideLength = value;
    notifyListeners();
  }

  void setSleeveLength(double value) {
    template.sleeveLength = value;
    notifyListeners();
  }

  void exportAsPDF() {
    // PDF 저장 로직 추가 가능
  }
}
