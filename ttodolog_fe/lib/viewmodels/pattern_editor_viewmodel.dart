import 'package:flutter/material.dart';
import 'package:ttodolog_fe/models/bottomup_template.dart';

class PatternEditorViewModel extends ChangeNotifier {
  BottomUpTemplate template;

  PatternEditorViewModel({required this.template});

  // ✅ 사용자 조정 가능 값
  double get frontNeckDepth => template.frontNeckDepth;
  double get armholeDepth => template.armholeDepth;
  double get sideLength => template.sideLength;
  double get bottomBandHeight => template.bottomBandHeight;
  double get neckWidth => template.neckWidth;
  double get shoulderWidth => template.shoulderWidth;
  double get chestWidth => template.chestWidth;
  double get sleeveLength => template.sleeveLength;
  double get sleeveBandHeight => template.sleeveBandHeight;
  double get sleeveWidth => template.sleeveWidth;
  double get wristWidth => template.wristWidth;

  // ✅ 조정 불가 (자동 업데이트되는 값)
  double get totalLength =>
      template.backNeckDepth + template.sideLength + template.shoulderSlope;
  double get backNeckDepth => template.backNeckDepth; // 고정 값
  double get shoulderSlope => template.shoulderSlope; // 고정 값
  double get armholeCut => (template.chestWidth - template.shoulderWidth) / 2;
  double get sleeveCapHeight => template.sleeveCapHeight; // 자동 계산됨

  void _updateAndNotify(void Function() updateFunction) {
    updateFunction();
    notifyListeners();
  }

  void setFrontNeckDepth(double value) =>
      _updateAndNotify(() => template.adjustFrontNeckDepth(value));
  void setArmholeDepth(double value) =>
      _updateAndNotify(() => template.adjustArmholeDepth(value));
  void setSideLength(double value) =>
      _updateAndNotify(() => template.adjustSideLength(value));
  void setBottomBandHeight(double value) =>
      _updateAndNotify(() => template.adjustBottomBandHeight(value));
  void setNeckWidth(double value) =>
      _updateAndNotify(() => template.adjustNeckWidth(value));
  void setShoulderWidth(double value) =>
      _updateAndNotify(() => template.adjustShoulderWidth(value));
  void setChestWidth(double value) =>
      _updateAndNotify(() => template.adjustChestWidth(value));
  void setSleeveLength(double value) =>
      _updateAndNotify(() => template.adjustSleeveLength(value));
  void setSleeveBandHeight(double value) =>
      _updateAndNotify(() => template.adjustSleeveBandHeight(value));
  void setSleeveWidth(double value) =>
      _updateAndNotify(() => template.adjustSleeveWidth(value));
  void setWristWidth(double value) =>
      _updateAndNotify(() => template.adjustWristWidth(value));
}
