import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';



  /// **📌 SVG 생성 함수 (앞판, 뒷판, 소매)**
  String _generateSVG(PatternEditorViewModel viewModel, String type) {
    double chestWidth = viewModel.chestWidth;
    double totalLength = viewModel.totalLength;
    double shoulderSlope = viewModel.shoulderSlope;
    double backNeckDepth = viewModel.backNeckDepth;
    double frontNeckDepth = viewModel.frontNeckDepth;
    double armholeDepth = viewModel.armholeDepth;
    double sideLength = viewModel.sideLength;
    double neckWidth = viewModel.neckWidth;
    double shoulderWidth = viewModel.shoulderWidth;
    double armholeCut = viewModel.armholeCut;
    double bottomBandHeight = viewModel.bottomBandHeight;
    double sleeveLength = viewModel.sleeveLength;
    double sleeveCapHeight = viewModel.sleeveCapHeight;
    double sleeveWidth = viewModel.sleeveWidth;
    double wristWidth = viewModel.wristWidth;
    double sleeveBandHeight = viewModel.sleeveBandHeight;

    double centerX = chestWidth / 2;

    // ✅ 목, 어깨, 가슴, 옆선 좌표 계산
    double leftNeckX = centerX - (neckWidth / 2);
    double rightNeckX = centerX + (neckWidth / 2);
    double shoulderY = armholeDepth + shoulderSlope;
    double armholeCurveStartY = armholeDepth / 3;
    double sideY = -sideLength;
    double bottomY = -(sideLength + bottomBandHeight);

    // ✅ 소매 좌표
    double leftSleeveX = 0;
    double leftSleeveBottomX = (sleeveWidth - wristWidth) / 2;
    double rightSleeveX = sleeveWidth;
    double rightSleeveBottomX = sleeveWidth - leftSleeveBottomX;
    double sleeveTopY = sleeveCapHeight;
    double sleeveBottomY = -(sleeveLength - sleeveCapHeight);
    double sleeveBandY = -(sleeveLength - sleeveCapHeight + sleeveBandHeight);

    // ✅ 4. 어깨점
    double leftShoulderX = leftArmholeX;
    double rightShoulderX = rightArmholeX;
    double shoulderY = armholeY - 5;

    // ✅ 5. 목 점
    double leftNeckX = centerX - (shoulderWidth / 4);
    double rightNeckX = centerX + (shoulderWidth / 4);
    double neckY = shoulderY - frontNeckDepth;

    return '''
    <svg width="2000" height="2000" viewBox="0 0 2000 2000" xmlns="http://www.w3.org/2000/svg">
      <!-- 십자가 중심 -->
      <line x1="$centerX" y1="0" x2="$centerX" y2="$totalLength" stroke="red" stroke-width="1"/>
      <line x1="0" y1="$centerY" x2="300" y2="$centerY" stroke="red" stroke-width="1"/>

      <!-- 밑단 -->
      <line x1="$leftBottomX" y1="$bottomY" x2="$rightBottomX" y2="$bottomY" stroke="black" stroke-width="2"/>
      
      <!-- 고무단 -->
      <line x1="$leftBottomX" y1="$bottomBandY" x2="$rightBottomX" y2="$bottomBandY" stroke="black" stroke-width="2"/>

      <!-- 진동 -->
      <line x1="$leftBottomX" y1="$bottomY" x2="$leftArmholeX" y2="$armholeY" stroke="black" stroke-width="2"/>
      <line x1="$rightBottomX" y1="$bottomY" x2="$rightArmholeX" y2="$armholeY" stroke="black" stroke-width="2"/>

      <!-- 어깨 -->
      <line x1="$leftArmholeX" y1="$armholeY" x2="$leftShoulderX" y2="$shoulderY" stroke="black" stroke-width="2"/>
      <line x1="$rightArmholeX" y1="$armholeY" x2="$rightShoulderX" y2="$shoulderY" stroke="black" stroke-width="2"/>

      <!-- 목 -->
      <line x1="$leftShoulderX" y1="$shoulderY" x2="$leftNeckX" y2="$neckY" stroke="black" stroke-width="2"/>
      <line x1="$rightShoulderX" y1="$shoulderY" x2="$rightNeckX" y2="$neckY" stroke="black" stroke-width="2"/>
      <path d="M$leftNeckX,$neckY Q$centerX,${neckY - 5} $rightNeckX,$neckY" stroke="black" fill="none" stroke-width="2"/>
    </svg>
    ''';
  }
}
