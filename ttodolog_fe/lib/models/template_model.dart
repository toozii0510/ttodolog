import 'package:ttodolog_fe/models/basic_body_shape_model.dart';

class TemplateModel {
  final String knittingMethod; // "top_down" 또는 "bottom_up"
  final String category; // "knit" 또는 "cardigan"
  final String fitType; // "slim_fit" 또는 "regular_fit"

  final double chestCircumference; // 가슴둘레
  final double shoulderSlope; // 어깨처짐
  final double backNeckDepth; // 뒷목깊이
  final double frontNeckDepth; // 앞목깊이
  final double armholeDepth; // 진동길이
  final double sideLength; // 옆선길이
  final double neckWidth; // 목너비
  final double shoulderWidth; // 어깨너비
  final double chestWidth; // 가슴너비
  final double sleeveCapHeight; // 소매산높이
  final double sleeveLength; // 소매길이
  final double sleeveWidth; // 소매너비
  final double wristWidth; // 손목너비
  final double bottomBandHeight; // 밑단밴드높이
  final double sleeveBandHeight; // 소매밴드높이
  final double neckBandHeight; // 넥밴드높이

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
    required this.neckBandHeight,
  });

  Map<String, double> toJson() {
    return {
      "chestCircumference": chestCircumference,
      "shoulderSlope": shoulderSlope,
      "backNeckDepth": backNeckDepth,
      "frontNeckDepth": frontNeckDepth,
      "armholeDepth": armholeDepth,
      "sideLength": sideLength,
      "neckWidth": neckWidth,
      "shoulderWidth": shoulderWidth,
      "chestWidth": chestWidth,
      "sleeveLength": sleeveLength,
      "sleeveWidth": sleeveWidth,
      "wristWidth": wristWidth,
      "sleeveCapHeight": sleeveCapHeight,
      "bottomBandHeight": bottomBandHeight,
      "sleeveBandHeight": sleeveBandHeight,
      "neckBandHeight": neckBandHeight,
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
    double? neckBandHeight,
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
      neckBandHeight: neckBandHeight ?? this.neckBandHeight,
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
      frontNeckDepth: (base.neckCircumference / 6) +
          base.backNeckDepth * easeValues['backNeckDepth']!,
      armholeDepth: base.armholeDepth + easeValues['armholeDepth']!,
      sideLength: base.backLength - base.armholeDepth + 12,
      neckWidth: ((base.neckCircumference / 6) + easeValues['neckWidth']!) * 2,
      shoulderWidth: base.shoulderWidth - easeValues['shoulderWidth']!,
      chestWidth: (chestCircumference / 2) + easeValues['chestWidth']!,
      sleeveCapHeight: (base.armholeDepth / 2),
      sleeveLength: base.armLength + easeValues['sleeveLength']!,
      sleeveWidth: (base.armCircumference / 2 * easeValues['sleeveWidth']!),
      wristWidth: base.wristCircumference / 2,
      bottomBandHeight: base.backNeckDepth + 2,
      sleeveBandHeight: base.backNeckDepth + 2,
      neckBandHeight: (base.backNeckDepth + 3) / 2,
    );
  }

  /// ✅ 핏에 따른 여유분 정의 (뜨는 방식과 카테고리는 영향 없음)
  static Map<String, double> _getEaseValuesByFit(String fitType) {
    if (fitType == "regular_fit") {
      return {
        "shoulderSlope": 0.6,
        "backNeckDepth": 1.2,
        "armholeDepth": 1.0,
        "neckWidth": 3.5,
        "shoulderWidth": 2.0,
        "chestWidth": 6.0,
        "sleeveLength": 2.0,
        "sleeveWidth": 1.15
      };
    } else if (fitType == "slim_fit") {
      return {
        "shoulderSlope": 0.6,
        "backNeckDepth": 1.1,
        "frontNeckDepth": 1.0,
        "armholeDepth": 1.5,
        "neckWidth": 3.0,
        "shoulderWidth": 1.5,
        "chestWidth": 2.0,
        "sleeveLength": 1.5,
        "sleeveWidth": 1.1
      };
    } else {
      return {
        "shoulderSlope": 0.0,
        "backNeckDepth": 0.0,
        "frontNeckDepth": 0.0,
        "armholeDepth": 0.0,
        "neckWidth": 0.0,
        "shoulderWidth": 0.0,
        "chestWidth": 0.0,
        "sleeveLength": 0.0,
        "sleeveWidth": 0.0
      };
    }
  }
}
