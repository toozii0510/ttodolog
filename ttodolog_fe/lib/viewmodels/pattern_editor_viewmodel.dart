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
  double get backNeckDepth => template.backNeckDepth; // 고정 값
  double get shoulderSlope => template.shoulderSlope; // 고정 값
  double get armholeCut => (template.chestWidth - template.shoulderWidth) / 2;
  double get sleeveCapHeight => template.sleeveCapHeight; // 자동 계산됨

  // ✅ Setter
  void _updateAndNotify(void Function() fn) {
    fn();
    notifyListeners();
  }

  void setFrontNeckDepth(double v) =>
      _updateAndNotify(() => template.adjustFrontNeckDepth(v));
  void setArmholeDepth(double v) =>
      _updateAndNotify(() => template.adjustArmholeDepth(v));
  void setSideLength(double v) =>
      _updateAndNotify(() => template.adjustSideLength(v));
  void setBottomBandHeight(double v) =>
      _updateAndNotify(() => template.adjustBottomBandHeight(v));
  void setNeckWidth(double v) =>
      _updateAndNotify(() => template.adjustNeckWidth(v));
  void setShoulderWidth(double v) =>
      _updateAndNotify(() => template.adjustShoulderWidth(v));
  void setChestWidth(double v) =>
      _updateAndNotify(() => template.adjustChestWidth(v));
  void setSleeveLength(double v) =>
      _updateAndNotify(() => template.adjustSleeveLength(v));
  void setSleeveBandHeight(double v) =>
      _updateAndNotify(() => template.adjustSleeveBandHeight(v));
  void setSleeveWidth(double v) =>
      _updateAndNotify(() => template.adjustSleeveWidth(v));
  void setWristWidth(double v) =>
      _updateAndNotify(() => template.adjustWristWidth(v));
}
