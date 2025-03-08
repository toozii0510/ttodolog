import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';

class PatternSVG extends StatelessWidget {
  final PatternEditorViewModel viewModel;

  const PatternSVG({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.string(
        _generateSVG(),
        width: 500,
        height: 500,
        fit: BoxFit.contain,
      ),
    );
  }

  String _generateSVG() {
    // 패턴 데이터를 가져옴
    double chestWidth = viewModel.template.chestWidth;
    double totalLength = viewModel.template.totalLength;
    double shoulderWidth = viewModel.template.shoulderWidth;
    double armholeDepth = viewModel.template.armholeDepth;
    double frontNeckDepth = viewModel.template.frontNeckDepth;
    double sleeveWidth = viewModel.template.sleeveWidth;
    double bottomBandHeight = viewModel.template.bottomBandHeight;

    // ✅ 1. 중심 십자가 (도안의 중심 표시용)
    double centerX = 150;
    double centerY = totalLength / 2;

    // ✅ 2. 밑단 & 고무단
    double bottomY = totalLength;
    double bottomBandY = bottomY + bottomBandHeight;
    double leftBottomX = centerX - (chestWidth / 2);
    double rightBottomX = centerX + (chestWidth / 2);

    // ✅ 3. 진동 끝점
    double leftArmholeX = leftBottomX + (chestWidth - shoulderWidth) / 2;
    double rightArmholeX = rightBottomX - (chestWidth - shoulderWidth) / 2;
    double armholeY = bottomY - armholeDepth;

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
