import 'dart:math';
import 'pattern_template.dart';

class BottomUpTemplate extends PatternTemplate {
  // ✅ 초기 값 (원형에서 가져옴)
  late double shoulderSlope;
  late double backNeckDepth;
  late double frontNeckDepth;
  late double armholeDepth;
  late double sideLength;
  late double neckWidth;
  late double shoulderWidth;
  late double chestWidth;
  late double armholeCut;
  late double sleeveCapHeight;
  late double sleeveLength;
  late double sleeveWidth;
  late double wristWidth;
  late double bottomBandHeight;
  late double sleeveBandHeight;

  // ✅ 사용자가 조정하는 값들
  double _adjustFrontNeckDepth = 0.0;
  double _adjustArmholeDepth = 0.0;
  double _adjustSideLength = 0.0;
  double _adjustBottomBandHeight = 0.0;
  double _adjustNeckWidth = 0.0;
  double _adjustShoulderWidth = 0.0;
  double _adjustChestWidth = 0.0;
  double _adjustSleeveLength = 0.0;
  double _adjustSleeveBandHeight = 0.0;
  double _adjustSleeveWidth = 0.0;
  double _adjustWristWidth = 0.0;

  BottomUpTemplate({
    required super.basePattern,
    required super.chestCircumference,
  }) {
    _calculateTemplateValues();
  }

  /// ✅ 기본 원형에서 여유분을 추가하여 초기값 설정
  void _calculateTemplateValues() {
    shoulderSlope = basePattern.shoulderSlope * 0.4;
    backNeckDepth = basePattern.backNeckDepth * 1.2;
    armholeDepth = basePattern.armholeDepth + 2;
    neckWidth = ((basePattern.neckWidth / 6) + 3.5) * 2;
    frontNeckDepth = (neckWidth / 6) + backNeckDepth;
    shoulderWidth = basePattern.shoulderWidth - 2;
    chestWidth = (chestCircumference / 2) + 6;
    armholeCut = (chestWidth - shoulderWidth) / 2;
    sleeveCapHeight = sqrt(pow(armholeDepth, 2) +
        pow(armholeCut, 2) -
        pow(basePattern.sleeveWidth, 2));
    sideLength = basePattern.sideLength;
    sleeveLength = basePattern.sleeveLength + 2;
    sleeveWidth = (basePattern.sleeveWidth / 2 * 1.15);
    wristWidth = (basePattern.wristWidth / 2);
    bottomBandHeight = basePattern.bottomBandHeight;
    sleeveBandHeight = basePattern.sleeveBandHeight;
  }

  /// ✅ 값 조정 메서드 (조정값 반영)
  void _updateAdjustedValues() {
    frontNeckDepth = basePattern.frontNeckDepth + _adjustFrontNeckDepth;
    armholeDepth = basePattern.armholeDepth + _adjustArmholeDepth;
    sideLength = basePattern.sideLength + _adjustSideLength;
    bottomBandHeight = basePattern.bottomBandHeight + _adjustBottomBandHeight;
    neckWidth = basePattern.neckWidth + _adjustNeckWidth;
    shoulderWidth = basePattern.shoulderWidth + _adjustShoulderWidth;
    chestWidth = basePattern.chestWidth + _adjustChestWidth;
    sleeveLength = basePattern.sleeveLength + _adjustSleeveLength;
    sleeveBandHeight = basePattern.sleeveBandHeight + _adjustSleeveBandHeight;
    sleeveWidth = basePattern.sleeveWidth + _adjustSleeveWidth;
    wristWidth = basePattern.wristWidth + _adjustWristWidth;
  }

  /// ✅ 값 조정 메서드 추가
  void adjustFrontNeckDepth(double value) {
    _adjustFrontNeckDepth = value;
    _updateAdjustedValues();
  }

  void adjustArmholeDepth(double value) {
    _adjustArmholeDepth = value;
    _updateAdjustedValues();
  }

  void adjustSideLength(double value) {
    _adjustSideLength = value;
    _updateAdjustedValues();
  }

  void adjustBottomBandHeight(double value) {
    _adjustBottomBandHeight = value;
    _updateAdjustedValues();
  }

  void adjustNeckWidth(double value) {
    _adjustNeckWidth = value;
    _updateAdjustedValues();
  }

  void adjustShoulderWidth(double value) {
    _adjustShoulderWidth = value;
    _updateAdjustedValues();
  }

  void adjustChestWidth(double value) {
    _adjustChestWidth = value;
    _updateAdjustedValues();
  }

  void adjustSleeveLength(double value) {
    _adjustSleeveLength = value;
    _updateAdjustedValues();
  }

  void adjustSleeveBandHeight(double value) {
    _adjustSleeveBandHeight = value;
    _updateAdjustedValues();
  }

  void adjustSleeveWidth(double value) {
    _adjustSleeveWidth = value;
    _updateAdjustedValues();
  }

  void adjustWristWidth(double value) {
    _adjustWristWidth = value;
    _updateAdjustedValues();
  }

  @override
  Map<String, double> getTemplateData() {
    return {
      "어깨처짐": shoulderSlope,
      "뒷목깊이": backNeckDepth,
      "앞목깊이": frontNeckDepth,
      "진동길이": armholeDepth,
      "옆길이": sideLength,
      "목너비": neckWidth,
      "어깨너비": shoulderWidth,
      "가슴너비": chestWidth,
      "진동파임": armholeCut,
      "소매산길이": sleeveCapHeight,
      "소매길이": sleeveLength,
      "소매너비": sleeveWidth,
      "손목너비": wristWidth,
      "아래 고무단 길이": bottomBandHeight,
      "소매 고무단 길이": sleeveBandHeight
    };
  }
}
