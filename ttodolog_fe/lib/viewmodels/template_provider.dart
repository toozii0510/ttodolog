import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/template_model.dart';
import '../models/basic_body_shape_model.dart';

/// ✅ 템플릿 선택 및 가슴둘레 입력을 관리하는 Provider
class TemplateProvider extends StateNotifier<TemplateModel?> {
  TemplateProvider() : super(null);

  /// **🚀 템플릿 선택 (Bottom-up Knit만 가능)**
  void updateSelection({
    required String knittingMethod,
    required String category,
    required String fitType,
  }) {
    if (knittingMethod != "bottom_up") {
      throw Exception("현재 바텀업 템플릿만 지원됩니다.");
    }

    state = TemplateModel(
      knittingMethod: knittingMethod,
      category: category,
      fitType: fitType,
      chestCircumference: 0.0, // 기본값 설정 (사용자가 입력해야 함)
      shoulderSlope: 0.0,
      backNeckDepth: 0.0,
      frontNeckDepth: 0.0,
      armholeDepth: 0.0,
      sideLength: 0.0,
      neckWidth: 0.0,
      shoulderWidth: 0.0,
      chestWidth: 0.0,
      sleeveCapHeight: 0.0,
      sleeveLength: 0.0,
      sleeveWidth: 0.0,
      wristWidth: 0.0,
      bottomBandHeight: 0.0,
      sleeveBandHeight: 0.0,
      neckBandHeight: 0.0,
    );
  }

  /// **🚀 가슴둘레 입력 후 상태 업데이트**
  void updateChestCircumference(double chestCircumference) {
    if (state == null) {
      throw Exception("템플릿이 선택되지 않았습니다.");
    }

    final bodyShape =
        BasicBodyShapeModel.getMatchingBodyShape(chestCircumference);

    state = TemplateModel.fromBaseShape(
      state!.knittingMethod,
      state!.category,
      state!.fitType,
      chestCircumference,
      bodyShape,
    );
  }

  /// **🚀 선택된 템플릿 검증**
  String? validateSelection() {
    if (state == null) return "템플릿이 선택되지 않았습니다.";
    if (state!.chestCircumference == 0.0) return "가슴둘레를 입력해주세요.";
    return null;
  }
}

/// **✅ Provider 등록**
final templateProviderNotifier =
    StateNotifierProvider<TemplateProvider, TemplateModel?>(
        (ref) => TemplateProvider());
