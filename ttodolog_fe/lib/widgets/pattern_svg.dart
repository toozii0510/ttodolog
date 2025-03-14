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

    return Container(
      color: Colors.grey.shade200, // 디버깅용 배경색
      child: SvgPicture.string(
        _generateSVG(measurementState, type),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }

  /// **🚀 SVG 생성 함수**
  String _generateSVG(TemplateModel measurementState, String type) {
    double baseY = 20.0;
    double centerX = 150.0;

    switch (type) {
      case "front":
        return _generateBodySVG(measurementState, centerX, baseY,
            isFront: true);
      case "back":
        return _generateBodySVG(measurementState, centerX, baseY,
            isFront: false);
      case "sleeve":
        return _generateSleeveSVG(measurementState);
      default:
        return "";
    }
  }

  /// **🚀 앞판 & 뒷판 (Body) SVG 생성**
  String _generateBodySVG(TemplateModel state, double centerX, double baseY,
      {required bool isFront}) {
    double neckLeft = centerX - (state.neckWidth / 2);
    double neckRight = centerX + (state.neckWidth / 2);
    double shoulderLeft = centerX - (state.shoulderWidth / 2);
    double shoulderRight = centerX + (state.shoulderWidth / 2);

    double neckHeight = baseY;
    double shoulderHeight = baseY + state.shoulderSlope;
    double armholeHeight = baseY + (state.shoulderSlope + state.armholeDepth);
    double armholeCurveHeight = baseY +
        (state.shoulderSlope + state.armholeDepth * (isFront ? 2 / 3 : 1 / 2));

    double hemHeight =
        baseY + (state.shoulderSlope + state.armholeDepth + state.sideLength);
    double chestStart = centerX - (state.chestWidth / 2);
    double chestEnd = centerX + (state.chestWidth / 2);
    double neckCurveDepth =
        baseY + (isFront ? state.frontNeckDepth : state.backNeckDepth);
    double bandHeight = hemHeight + state.bottomBandHeight;

    return '''
    <svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-800,0),scale(10)">
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
          Z"
          stroke="black" fill="none" stroke-width="1"/>
      </g>
    </svg>
    ''';
  }

  /// **🚀 소매 SVG 생성**
  String _generateSleeveSVG(TemplateModel state) {
    double baseY = 20.0;
    double centerX = 150; // 중앙 X 좌표

    double scL1 = centerX - (state.sleeveWidth / 3); // 왼쪽 제어점 1
    double scR1 = centerX + (state.sleeveWidth / 3); // 오른쪽 제어점 1
    double scL2 = centerX - (state.sleeveWidth - 3); // 왼쪽 제어점 2
    double scR2 = centerX + (state.sleeveWidth - 3);
    double swL = centerX - (state.sleeveWidth); // 소매너비
    double swR = centerX + (state.sleeveWidth);
    double wristLeft = centerX - (state.wristWidth); // 손목 너비
    double wristRight = centerX + (state.wristWidth);

    double sleeveTop = baseY; // 소매 최상단 높이
    double sleeveCapHeight = baseY + state.sleeveCapHeight; // 소매산 높이
    double sleeveHeight = baseY + state.sleeveLength; // 소매 길이
    double sleeveBottom =
        baseY + (state.sleeveLength + state.sleeveBandHeight); // 소매 고무단 길이

    return '''
  <svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-800,0),scale(10)">
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
      </g>
    </svg>
    ''';
  }
}
