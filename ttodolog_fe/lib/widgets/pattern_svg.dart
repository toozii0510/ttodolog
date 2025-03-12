import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';

class PatternSVG extends StatelessWidget {
  final String type; // "front", "back", "sleeve"

  const PatternSVG({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatternEditorViewModel>(
      builder: (context, vm, child) {
        final svgStr = _generateSVG(vm, type);
        return Container(
          color: Colors.grey.shade200,
          child: SvgPicture.string(
            svgStr,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

/// **type**별로 다른 Path 생성
String _generateSVG(PatternEditorViewModel vm, String type) {
  switch (type) {
    case "front":
      return _generateBodySVG(vm, isFront: true);
    case "back":
      return _generateBodySVG(vm, isFront: false);
    case "sleeve":
      return _generateSleeveSVG(vm);
    default:
      return '';
  }
}

// ----------------------------------------------------------------
// (1) 몸판 (앞/뒤)
// ----------------------------------------------------------------
String _generateBodySVG(PatternEditorViewModel vm, {required bool isFront}) {
  // (A) centerX, baseY를 임의로 설정 (도안의 기준점)
  //     필요하다면, 외부 파라미터로 받아도 됨.
  const double centerX = 50.0;
  const double baseY = 4.0;

  // **사용자 원본 코드**에서 썼던 변수들
  double neckLeft = centerX - (vm.neckWidth / 2);
  double neckRight = centerX + (vm.neckWidth / 2);
  double shoulderLeft = centerX - (vm.shoulderWidth / 2);
  double shoulderRight = centerX + (vm.shoulderWidth / 2);

  double neckHeight = baseY;
  double shoulderHeight = baseY + vm.shoulderSlope;

  double armholeHeight = baseY + (vm.shoulderSlope + vm.armholeDepth);

  // 암홀 곡선을 살짝 만들고 싶다면, 중간 지점(armholeCurveHeight) 설정 가능
  // 예: 앞판이면 2/3, 뒷판이면 1/2
  double armholeCurveHeight =
      baseY + vm.shoulderSlope + vm.armholeDepth * (isFront ? 2.0 / 3.0 : 0.5);

  double hemHeight =
      baseY + (vm.shoulderSlope + vm.armholeDepth + vm.sideLength);

  double chestStart = centerX - (vm.chestWidth / 2);
  double chestEnd = centerX + (vm.chestWidth / 2);

  // 네크라인 곡선 깊이
  double neckCurveDepth =
      baseY + (isFront ? vm.frontNeckDepth : vm.backNeckDepth);

  // 아래 고무단 높이 (bandHeight)는 추가로 사용 가능
  double bandHeight = baseY +
      (vm.shoulderSlope +
          vm.armholeDepth +
          vm.sideLength +
          vm.bottomBandHeight);

  // ------------------------------------------
  // SVG Header
  const svgHeader = '''
<svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
  <g transform="translate(100,100) scale(10)">
    <!-- 디버그용 배경 -->
    <rect x="-20" y="-20" width="600" height="800" fill="rgba(255,0,0,0.05)" />
''';

  // ------------------------------------------
  // Path 설명:
  //
  // 1) (neckLeft, neckHeight) → (neckRight, neckHeight)을
  //    Q(Quadratic Bézier)로 그려서 **네크라인** 좌우 대칭
  //    Control Point = (centerX, neckCurveDepth)
  //
  // 2) 어깨선 → (shoulderRight, shoulderHeight)
  // 3) 암홀 곡선 부분:
  //    - (shoulderRight, armholeCurveHeight) / (shoulderRight, armholeHeight)
  //    - (chestEnd, armholeHeight)
  //
  // 4) 옆선 + 밑단:
  //    - (chestEnd, hemHeight) → (chestStart, hemHeight)
  //
  // 5) 암홀 왼쪽, 어깨 왼쪽:
  //    - (chestStart, armholeHeight) → (shoulderLeft, armholeHeight) → ...
  //
  // 닫기(Z)
  //
  // ※ 필요하면 여기서 특정 구간을 Cubic Bézier로 바꿔 더 부드럽게 만들 수도 있음.

  final path = '''
<path d="
  M $neckLeft,$neckHeight
  Q $centerX,$neckCurveDepth $neckRight,$neckHeight

  L $shoulderRight,$shoulderHeight
  L $shoulderRight,$armholeCurveHeight
  L $shoulderRight,$armholeHeight
  L $chestEnd,$armholeHeight
  L $chestEnd,$hemHeight
  L $chestStart,$hemHeight
  L $chestStart,$armholeHeight
  L $shoulderLeft,$armholeHeight
  L $shoulderLeft,$armholeCurveHeight
  L $shoulderLeft,$shoulderHeight
  Z
"
fill="none" stroke="${isFront ? 'blue' : 'red'}" stroke-width="1" />
''';

  const svgFooter = '''
  </g>
</svg>
''';

  return svgHeader + path + svgFooter;
}

// ----------------------------------------------------------------
// (2) 소매 (보다 정교한 소매산)
// ----------------------------------------------------------------
String _generateSleeveSVG(PatternEditorViewModel vm) {
  // 예: 소매 길이, 너비, 소매산 높이, 손목 너비
  final double sLen = vm.sleeveLength;
  final double sWidth = vm.sleeveWidth;
  final double capH = vm.sleeveCapHeight;
  final double wristW = vm.wristWidth;

  const svgHeader = '''
<svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
  <g transform="translate(100,100) scale()">
    <rect x="-20" y="-20" width="600" height="800" fill="rgba(0,255,0,0.05)" />
''';

  // 소매산을 Cubic Bézier로 표현
  final cp1x = sWidth * 0.3;
  final cp1y = -capH;
  final cp2x = sWidth * 0.7;
  final cp2y = -capH;

  final path = '''
<path d="
  M 0,0
  C $cp1x,$cp1y $cp2x,$cp2y $sWidth,0
  L $wristW,$sLen
  L 0,$sLen
  Z
"
fill="none" stroke="green" stroke-width="1" />
''';

  const svgFooter = '''
  </g>
</svg>
''';

  return svgHeader + path + svgFooter;
}
