import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';

class PatternSVG extends StatelessWidget {
  final String type;

  const PatternSVG({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatternEditorViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          color: Colors.grey.shade200, // 디버깅용 배경색
          child: SvgPicture.string(
            _generateSVG(viewModel, type),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  String _generateSVG(PatternEditorViewModel viewModel, String type) {
    double baseY = 20.0;
    double centerX = 120.0;

    switch (type) {
      case "front":
        return _generateBodySVG(viewModel, centerX, baseY, isFront: true);
      case "back":
        return _generateBodySVG(viewModel, centerX, baseY, isFront: false);
      case "sleeve":
        return _generateSleeveSVG(viewModel);
      default:
        return "";
    }
  }

  /// **✅ 앞판 & 뒷판 (Body) SVG 생성 (중앙 대칭 활용)**
  String _generateBodySVG(
      PatternEditorViewModel viewModel, double centerX, double baseY,
      {required bool isFront}) {
    double neckLeft = centerX - (viewModel.neckWidth / 2);
    double neckRight = centerX + (viewModel.neckWidth / 2);
    double shoulderLeft = centerX - (viewModel.shoulderWidth / 2);
    double shoulderRight = centerX + (viewModel.shoulderWidth / 2);

    double neckHeight = baseY;
    double shoulderHeight = baseY + (viewModel.shoulderSlope);
    double armholeHeight =
        baseY + (viewModel.shoulderSlope + viewModel.armholeDepth);
    double armholeCurveHeight = baseY +
        (viewModel.shoulderSlope +
            viewModel.armholeDepth * (isFront ? 2 / 3 : 1 / 2));

    double hemHeight = baseY +
        (viewModel.shoulderSlope +
            viewModel.armholeDepth +
            viewModel.sideLength);
    double chestStart = centerX - (viewModel.chestWidth / 2);
    double chestEnd = centerX + (viewModel.chestWidth / 2);
    double neckCurveDepth =
        baseY + (isFront ? viewModel.frontNeckDepth : viewModel.backNeckDepth);
    double bandHeight = baseY +
        (viewModel.shoulderSlope +
            viewModel.armholeDepth +
            viewModel.sideLength +
            viewModel.bottomBandHeight);

    return '''
    <svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-800,0),scale(10)">
        <rect x="0" y="0" width="1200" height="1000" fill="rgba(255, 0, 0, 0.2)" />
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

  String _generateSleeveSVG(PatternEditorViewModel viewModel) {
    double baseY = 20.0;

    double centerX = 120; //중앙 X 좌표
    double scL1 = centerX - (viewModel.sleeveWidth / 3); //왼쪽 제어점 1
    double scR1 = centerX + (viewModel.sleeveWidth / 3); //오른쪽 제어점 1
    double scL2 = centerX - (viewModel.sleeveWidth - 3); //왼쪽 제어점 2
    double scR2 = centerX + (viewModel.sleeveWidth - 3);
    double swL = centerX - (viewModel.sleeveWidth); // 소매너비
    double swR = centerX + (viewModel.sleeveWidth);
    double wristLeft = centerX - (viewModel.wristWidth); //손목 너비
    double wristRight = centerX + (viewModel.wristWidth);

    double sleeveTop = baseY; //소매 최상단 높이
    double sleeveCapHeight = baseY + viewModel.sleeveCapHeight; // 소매산 높이
    double sleeveHeight = baseY + viewModel.sleeveLength; // 소매 길이
    double sleeveBottom = baseY +
        (viewModel.sleeveLength + viewModel.sleeveBandHeight); //소매 고무단 길이

    return '''
  <svg width="600" height="600" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-800,0),scale(10)">
      <rect x="0" y="0" width="1200" height="1000" fill="rgba(255, 0, 0, 0.2)" />
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
