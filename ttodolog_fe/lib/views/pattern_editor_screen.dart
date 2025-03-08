import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/%08viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/widgets/pattern_svg.dart';
import 'package:ttodolog_fe/widgets/pattern_slider.dart';

class PatternEditorScreen extends StatelessWidget {
  const PatternEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('도안 조정 화면')),
      body: Consumer<PatternEditorViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              // ✅ SVG 패턴 영역 (앞판, 뒷판, 소매)
              const Expanded(
                flex: 2, // 전체 화면의 40% 차지
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: PatternSVG(type: "front")), // 앞판
                    Expanded(child: PatternSVG(type: "back")), // 뒷판
                    Expanded(child: PatternSVG(type: "sleeve")), // 소매
                  ],
                ),
              ),

              // ✅ 슬라이더 UI 영역 (몸판 길이, 몸판 너비, 소매 조정)
              Expanded(
                flex: 3, // 전체 화면의 60% 차지
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSliderSection(
                          "몸판 길이 조정",
                          [
                            _buildSlider(
                                viewModel,
                                '앞목 깊이',
                                viewModel.frontNeckDepth,
                                viewModel.template.frontNeckDepth),
                            _buildSlider(
                                viewModel,
                                '진동 길이',
                                viewModel.armholeDepth,
                                viewModel.template.armholeDepth),
                            _buildSlider(viewModel, '옆길이', viewModel.sideLength,
                                viewModel.template.sideLength),
                            _buildSlider(
                                viewModel,
                                '고무단 길이',
                                viewModel.bottomBandHeight,
                                viewModel.template.bottomBandHeight),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSliderSection(
                          "몸판 너비 조정",
                          [
                            _buildSlider(viewModel, '목 너비', viewModel.neckWidth,
                                viewModel.template.neckWidth),
                            _buildSlider(
                                viewModel,
                                '어깨 너비',
                                viewModel.shoulderWidth,
                                viewModel.template.shoulderWidth),
                            _buildSlider(
                                viewModel,
                                '가슴 너비',
                                viewModel.chestWidth,
                                viewModel.template.chestWidth),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSliderSection(
                          "소매 조정",
                          [
                            _buildSlider(
                                viewModel,
                                '소매 길이',
                                viewModel.sleeveLength,
                                viewModel.template.sleeveLength),
                            _buildSlider(
                                viewModel,
                                '소매 고무단 길이',
                                viewModel.sleeveBandHeight,
                                viewModel.template.sleeveBandHeight),
                            _buildSlider(
                                viewModel,
                                '소매 너비',
                                viewModel.sleeveWidth,
                                viewModel.template.sleeveWidth),
                            _buildSlider(
                                viewModel,
                                '손목 너비',
                                viewModel.wristWidth,
                                viewModel.template.wristWidth),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// **📌 슬라이더 그룹 UI 생성**
  Widget _buildSliderSection(String title, List<Widget> sliders) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade50, // 배경색 추가
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Column(children: sliders),
        ],
      ),
    );
  }

  /// **개별 슬라이더 UI 생성**
  Widget _buildSlider(PatternEditorViewModel viewModel, String label,
      double value, double defaultValue) {
    final Map<String, double> sliderRanges = {
      '앞목 깊이': 2, // ±2cm
      '진동 길이': 3, // ±3cm
      '옆길이': 5, // ±5cm
      '고무단 길이': 2, // ±2cm
      '목 너비': 1.5, // ±1.5cm
      '어깨 너비': 3, // ±3cm
      '가슴 너비': 4, // ±4cm
      '소매 길이': 6, // ±6cm
      '소매 고무단 길이': 2, // ±2cm
      '소매 너비': 1, // ±1cm
      '손목 너비': 1.5, // ±1.5cm
    };

    double range = sliderRanges[label] ?? 4; // 기본적으로 ±4cm 설정

    return PatternSlider(
      label: label,
      value: value,
      min: defaultValue - range, // ✅ 각 슬라이더마다 다른 min 값 설정
      max: defaultValue + range, // ✅ 각 슬라이더마다 다른 max 값 설정
      defaultValue: defaultValue,
      scale: 10,
      onChanged: (val) {
        if (label == '앞목 깊이') viewModel.setFrontNeckDepth(val);
        if (label == '진동 길이') viewModel.setArmholeDepth(val);
        if (label == '옆길이') viewModel.setSideLength(val);
        if (label == '고무단 길이') viewModel.setBottomBandHeight(val);
        if (label == '목 너비') viewModel.setNeckWidth(val);
        if (label == '어깨 너비') viewModel.setShoulderWidth(val);
        if (label == '가슴 너비') viewModel.setChestWidth(val);
        if (label == '소매 길이') viewModel.setSleeveLength(val);
        if (label == '소매 고무단 길이') viewModel.setSleeveBandHeight(val);
        if (label == '소매 너비') viewModel.setSleeveWidth(val);
        if (label == '손목 너비') viewModel.setWristWidth(val);
      },
    );
  }
}
