import 'dart:math';
import 'base_pattern_model.dart';
import 'pattern_template.dart';

class BottomUpTemplate extends PatternTemplate {
  late double totalLength;
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

  BottomUpTemplate({
    required super.basePattern,
    required super.chestCircumference,
  }) {
    _calculateTemplateValues();
  }

  /// ✅ 기본 원형에 여유분을 추가하여 값 계산
  void _calculateTemplateValues() {
    shoulderSlope = basePattern.shoulderSlope * 0.6;
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
    sideLength = basePattern.sideLength - (armholeDepth + shoulderSlope);
    totalLength = backNeckDepth + sideLength + 16;
    sleeveLength = basePattern.sleeveLength + 2;
    sleeveWidth = (basePattern.sleeveWidth / 2 * 1.15);
    wristWidth = (basePattern.wristWidth / 2);
    bottomBandHeight = basePattern.bottomBandHeight;
  }

  @override
  Map<String, double> getTemplateData() {
    return {
      "총장": totalLength,
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
      "아래 고무단 길이": bottomBandHeight
    };
  }
}
