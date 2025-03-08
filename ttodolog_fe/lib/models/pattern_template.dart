//템플릿 원형에서 가슴 둘레에 따른 부위별 신체 치수를 가져옴
import 'package:ttodolog_fe/models/base_pattern_model.dart';

abstract class PatternTemplate {
  final BasePatternModel basePattern;
  final double chestCircumference;

  PatternTemplate({
    required this.basePattern,
    required this.chestCircumference,
  });

  Map<String, double> getTemplateData();
}
