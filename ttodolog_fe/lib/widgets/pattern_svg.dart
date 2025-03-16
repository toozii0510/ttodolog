import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttodolog_fe/%08viewmodels/measurement_viewmodel.dart';
import 'package:ttodolog_fe/models/template_model.dart';

class PatternSVG extends ConsumerWidget {
  final String type;

  const PatternSVG({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TemplateModel measurementState =
        ref.watch(measurementViewModelProvider);

    return Row(
      children: [
        // 앞판
        Expanded(
          child: Container(
            color: Colors.white, // 앞판 배경색 (디버깅용)
            child: SvgPicture.string(
              _generateSVG(measurementState, type),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  /// **🚀 SVG 생성 함수**
  String _generateSVG(TemplateModel measurementState, String type) {
    double viewBoxWidth = 200.0; // 각 ViewBox 너비 (화면 3등분)
    double viewBoxHeight = 200.0; // 각 ViewBox 높이

    switch (type) {
      case "front":
        return _generateBodySVG(measurementState, viewBoxWidth, viewBoxHeight,
            isFront: true);
      case "back":
        return _generateBodySVG(measurementState, viewBoxWidth, viewBoxHeight,
            isFront: false);
      case "sleeve":
        return _generateSleeveSVG(
            measurementState, viewBoxWidth, viewBoxHeight);
      default:
        return "";
    }
  }

  /// **🚀 앞판 & 뒷판 (Body) SVG 생성**
  String _generateBodySVG(
      TemplateModel state, double viewBoxWidth, double viewBoxHeight,
      {required bool isFront}) {
    double centerX = viewBoxWidth / 2;
    double centerY = viewBoxHeight / 2;

    double neckLeft = centerX - (state.neckWidth / 2);
    double neckRight = centerX + (state.neckWidth / 2);
    double shoulderLeft = centerX - (state.shoulderWidth / 2);
    double shoulderRight = centerX + (state.shoulderWidth / 2);
    double chestLeft = centerX - (state.chestWidth / 2);
    double chestRight = centerX + (state.chestWidth / 2);

    double baseY = centerY - state.sideLength / 2;
    double shoulderHeight = baseY + state.shoulderSlope;
    double armholeHeight = shoulderHeight + state.armholeDepth;
    double hemHeight = armholeHeight + state.sideLength;
    double bottomBandHeight = hemHeight + state.bottomBandHeight;
    double neckDepth =
        baseY + (isFront ? state.frontNeckDepth : state.backNeckDepth);

    return '''
    <svg width="100%" height="100%" viewBox="0 0 $viewBoxWidth $viewBoxHeight" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-40, -50) scale(1.5)"> 
        <!-- 몸통 부분 -->
        <path d="
          M $neckLeft,$baseY 
          Q $centerX,$neckDepth $neckRight,$baseY
          L $shoulderRight,$shoulderHeight
          L $shoulderRight,$armholeHeight       
          L $chestRight,$armholeHeight         
          L $chestRight,$hemHeight
          L $chestRight,$bottomBandHeight
          L $chestLeft,$bottomBandHeight
          L $chestLeft,$hemHeight
          L $chestLeft,$armholeHeight
          L $shoulderLeft,$armholeHeight
          L $shoulderLeft,$shoulderHeight
          Z"
          stroke="black" fill="none" stroke-width="1"/>
  <!-- 밑단 밴드 추가 -->
  <line x1="$chestLeft" y1="$hemHeight" x2="$chestRight" y2="$hemHeight" stroke="black" stroke-width="0.7" />
      </g>
    </svg>
    ''';
  }

  /// **🚀 소매 SVG 생성**
  String _generateSleeveSVG(
      TemplateModel state, double viewBoxWidth, double viewBoxHeight) {
    double centerX = viewBoxWidth / 2;
    double centerY = viewBoxHeight / 2;

    double scL1 = centerX - (state.sleeveWidth / 3); // 왼쪽 제어점 1
    double scR1 = centerX + (state.sleeveWidth / 3); // 오른쪽 제어점 1
    double scL2 = centerX - (state.sleeveWidth - 3); // 왼쪽 제어점 2
    double scR2 = centerX + (state.sleeveWidth - 3);
    double swL = centerX - (state.sleeveWidth); // 소매너비
    double swR = centerX + (state.sleeveWidth);
    double wristLeft = centerX - (state.wristWidth); // 손목 너비
    double wristRight = centerX + (state.wristWidth);

    double sleeveTop = centerY - state.sleeveCapHeight; // 소매 최상단 높이
    double sleeveCapHeight = centerY; // 소매산 높이
    double sleeveHeight = centerY + state.sleeveLength; // 소매 길이
    double sleeveBottom = sleeveHeight + state.sleeveBandHeight; // 소매 고무단 길이

    return '''
  <svg width="100%" height="100%" viewBox="0 0 $viewBoxWidth $viewBoxHeight" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-50, -65) scale(1.5)"> <!-- ✅ 중앙 정렬 -->
        <path d="M $scL1,$sleeveTop
                L $centerX,$sleeveTop        
                L $scR1,$sleeveTop
                L $scR2,$sleeveCapHeight
                L $swR,$sleeveCapHeight 
                L $wristRight,$sleeveHeight
                L $wristRight,$sleeveBottom 
                L $wristLeft,$sleeveBottom 
                L $wristLeft,$sleeveHeight
                L $swL,$sleeveCapHeight
                L $scL2,$sleeveCapHeight
                L $scL1,$sleeveTop
                Z"
              stroke="black" fill="none" stroke-width="1"/>
<!-- 소매 밴드 구분선 -->
  <line x1="${centerX - state.wristWidth}" y1="$sleeveHeight" x2="${centerX + state.wristWidth}" y2="$sleeveHeight"
    stroke="black" stroke-width="0.7" />     
      </g>
    </svg>
    ''';
  }
}
