import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/widgets/pattern_slider.dart';
import 'package:ttodolog_fe/widgets/pattern_svg.dart';

class PatternEditorPage extends StatelessWidget {
  const PatternEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PatternEditorViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('도안 조정 화면')),
      body: Column(
        children: [
          // SVG 패턴 미리보기
          Expanded(child: PatternSVG(viewModel: viewModel)),

          // 슬라이더 조정 UI
          Expanded(
            child: ListView(
              children: [
                PatternSlider(
                    label: '앞목 깊이',
                    value: viewModel.frontNeckDepth,
                    min: 5,
                    max: 9,
                    onChanged: viewModel.setFrontNeckDepth),
                PatternSlider(
                    label: '진동길이',
                    value: viewModel.armholeDepth,
                    min: 17,
                    max: 21,
                    onChanged: viewModel.setArmholeDepth),
                PatternSlider(
                    label: '옆길이',
                    value: viewModel.sideLength,
                    min: 25,
                    max: 35,
                    onChanged: viewModel.setSideLength),
                PatternSlider(
                    label: '소매 길이',
                    value: viewModel.sleeveLength,
                    min: 46,
                    max: 56,
                    onChanged: viewModel.setSleeveLength),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
