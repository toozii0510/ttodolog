import 'package:ttodolog_fe/models/basic_body_shape_model.dart';

class TemplateModel {
  final String knittingMethod; // "top_down" 또는 "bottom_up"
  final String category; // "knit" 또는 "cardigan"
  final String fitType; // "slim_fit" 또는 "regular_fit"
  final double chestCircumference;
  final double shoulderSlope;
  final double backNeckDepth;
  final double frontNeckDepth;
  final double armholeDepth;
  final double sideLength;
  final double neckWidth;
  final double shoulderWidth;
  final double chestWidth;
  final double sleeveCapHeight;
  final double sleeveLength;
  final double sleeveWidth;
  final double wristWidth;
  final double bottomBandHeight;
  final double sleeveBandHeight;

  TemplateModel({
    required this.knittingMethod,
    required this.category,
    required this.fitType,
    required this.chestCircumference,
    required this.shoulderSlope,
    required this.backNeckDepth,
    required this.frontNeckDepth,
    required this.armholeDepth,
    required this.sideLength,
    required this.neckWidth,
    required this.shoulderWidth,
    required this.chestWidth,
    required this.sleeveCapHeight,
    required this.sleeveLength,
    required this.sleeveWidth,
    required this.wristWidth,
    required this.bottomBandHeight,
    required this.sleeveBandHeight,
  });

  Map<String, double> toJson() {
    return {
      "frontNeckDepth": frontNeckDepth,
      "armholeDepth": armholeDepth,
      "sideLength": sideLength,
      "bottomBandHeight": bottomBandHeight,
      "neckWidth": neckWidth,
      "shoulderWidth": shoulderWidth,
      "chestWidth": chestWidth,
      "sleeveLength": sleeveLength,
      "sleeveBandHeight": sleeveBandHeight,
      "sleeveWidth": sleeveWidth,
      "wristWidth": wristWidth,
      "shoulderSlope": shoulderSlope,
      "backNeckDepth": backNeckDepth,
      "chestCircumference": chestCircumference,
      "sleeveCapHeight": sleeveCapHeight,
    };
  }

  /// ✅ `copyWith` 메서드 추가 (값 변경 시 사용)
  TemplateModel copyWith({
    double? shoulderSlope,
    double? backNeckDepth,
    double? frontNeckDepth,
    double? armholeDepth,
    double? sideLength,
    double? neckWidth,
    double? shoulderWidth,
    double? chestWidth,
    double? sleeveCapHeight,
    double? sleeveLength,
    double? sleeveWidth,
    double? wristWidth,
    double? bottomBandHeight,
    double? sleeveBandHeight,
  }) {
    return TemplateModel(
      knittingMethod: knittingMethod,
      category: category,
      fitType: fitType,
      chestCircumference: chestCircumference,
      shoulderSlope: shoulderSlope ?? this.shoulderSlope,
      backNeckDepth: backNeckDepth ?? this.backNeckDepth,
      frontNeckDepth: frontNeckDepth ?? this.frontNeckDepth,
      armholeDepth: armholeDepth ?? this.armholeDepth,
      sideLength: sideLength ?? this.sideLength,
      neckWidth: neckWidth ?? this.neckWidth,
      shoulderWidth: shoulderWidth ?? this.shoulderWidth,
      chestWidth: chestWidth ?? this.chestWidth,
      sleeveCapHeight: sleeveCapHeight ?? this.sleeveCapHeight,
      sleeveLength: sleeveLength ?? this.sleeveLength,
      sleeveWidth: sleeveWidth ?? this.sleeveWidth,
      wristWidth: wristWidth ?? this.wristWidth,
      bottomBandHeight: bottomBandHeight ?? this.bottomBandHeight,
      sleeveBandHeight: sleeveBandHeight ?? this.sleeveBandHeight,
    );
  }

  /// ✅ 기본 원형에서 핏에 따른 여유분을 적용하여 템플릿 생성
  static TemplateModel fromBaseShape(String knittingMethod, String category,
      String fitType, double chestCircumference, BasicBodyShapeModel base) {
    final easeValues = _getEaseValuesByFit(fitType);

    return TemplateModel(
      knittingMethod: knittingMethod,
      category: category,
      fitType: fitType,
      chestCircumference: chestCircumference,

      // ✅ 핏에 따른 여유분 적용 (뜨는 방식, 카테고리는 레이아웃에만 영향)
      shoulderSlope: base.shoulderSlope * easeValues['shoulderSlope']!,
      backNeckDepth: base.backNeckDepth * easeValues['backNeckDepth']!,
      frontNeckDepth: (base.neckWidth / 6) +
          base.backNeckDepth * easeValues['frontNeckDepth']!,
      armholeDepth: base.armholeDepth + easeValues['armholeDepth']!,
      sideLength: base.sideLength, // 변동 없음
      neckWidth: ((base.neckWidth / 6) + easeValues['neckWidth']!) * 2,
      shoulderWidth: base.shoulderWidth - easeValues['shoulderWidth']!,
      chestWidth: (chestCircumference / 2) + easeValues['chestWidth']!,
      sleeveCapHeight: (base.armholeDepth / 2),
      sleeveLength: base.sleeveLength + easeValues['sleeveLength']!,
      sleeveWidth: (base.sleeveWidth / 2 * easeValues['sleeveWidth']!),
      wristWidth: base.wristWidth / 2,
      bottomBandHeight: base.bottomBandHeight,
      sleeveBandHeight: base.sleeveBandHeight,
    );
  }

  /// ✅ 핏에 따른 여유분 정의 (뜨는 방식과 카테고리는 영향 없음)
  static Map<String, double> _getEaseValuesByFit(String fitType) {
    if (fitType == "regular_fit") {
      return {
        "shoulderSlope": 0.4,
        "backNeckDepth": 1.2,
        "frontNeckDepth": 1.0,
        "armholeDepth": 2.0,
        "neckWidth": 3.5,
        "shoulderWidth": 2.0,
        "chestWidth": 4.0,
        "sleeveLength": 2.0,
        "sleeveWidth": 1.15
      };
    } else if (fitType == "slim_fit") {
      return {
        "shoulderSlope": 0.4,
        "backNeckDepth": 1.1,
        "frontNeckDepth": 1.0,
        "armholeDepth": 1.5,
        "neckWidth": 3.0,
        "shoulderWidth": 1.5,
        "chestWidth": 2.0,
        "sleeveLength": 1.5,
        "sleeveWidth": 1.1
      };
    }
    return {
      "shoulderSlope": 0.4,
      "backNeckDepth": 1.2,
      "frontNeckDepth": 1.0,
      "armholeDepth": 2.0,
      "neckWidth": 3.5,
      "shoulderWidth": 2.0,
      "chestWidth": 4.0,
      "sleeveLength": 2.0,
      "sleeveWidth": 1.15
    };
  }
}
