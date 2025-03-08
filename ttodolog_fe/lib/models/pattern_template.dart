//템플릿 부모 클래스(추상 클래스)
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
