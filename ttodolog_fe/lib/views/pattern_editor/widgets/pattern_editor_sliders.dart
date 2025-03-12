import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttodolog_fe/viewmodels/pattern_editor_viewmodel.dart';
import 'package:ttodolog_fe/widgets/pattern_slider.dart';

class PatternEditorSliders extends StatelessWidget {
  const PatternEditorSliders({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PatternEditorViewModel>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSliderSection(
              "몸판 길이 조정",
              [
                _buildSlider(
                  vm,
                  label: '앞목 깊이',
                  value: vm.frontNeckDepth, // cm
                  defaultValue: vm.template.frontNeckDepth, // cm
                ),
                _buildSlider(
                  vm,
                  label: '진동 길이',
                  value: vm.armholeDepth,
                  defaultValue: vm.template.armholeDepth,
                ),
                _buildSlider(
                  vm,
                  label: '옆길이',
                  value: vm.sideLength,
                  defaultValue: vm.template.sideLength,
                ),
                _buildSlider(
                  vm,
                  label: '고무단 길이',
                  value: vm.bottomBandHeight,
                  defaultValue: vm.template.bottomBandHeight,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSliderSection(
              "몸판 너비 조정",
              [
                _buildSlider(
                  vm,
                  label: '목 너비',
                  value: vm.neckWidth,
                  defaultValue: vm.template.neckWidth,
                ),
                _buildSlider(
                  vm,
                  label: '어깨 너비',
                  value: vm.shoulderWidth,
                  defaultValue: vm.template.shoulderWidth,
                ),
                _buildSlider(
                  vm,
                  label: '가슴 너비',
                  value: vm.chestWidth,
                  defaultValue: vm.template.chestWidth,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSliderSection(
              "소매 조정",
              [
                _buildSlider(
                  vm,
                  label: '소매 길이',
                  value: vm.sleeveLength,
                  defaultValue: vm.template.sleeveLength,
                ),
                _buildSlider(
                  vm,
                  label: '소매 고무단 길이',
                  value: vm.sleeveBandHeight,
                  defaultValue: vm.template.sleeveBandHeight,
                ),
                _buildSlider(
                  vm,
                  label: '소매 너비',
                  value: vm.sleeveWidth,
                  defaultValue: vm.template.sleeveWidth,
                ),
                _buildSlider(
                  vm,
                  label: '손목 너비',
                  value: vm.wristWidth,
                  defaultValue: vm.template.wristWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSection(String title, List<Widget> sliders) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
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
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Column(children: sliders),
        ],
      ),
    );
  }

  Widget _buildSlider(
    PatternEditorViewModel vm, {
    required String label,
    required double value,
    required double defaultValue,
  }) {
    // 슬라이더 ± 범위
    final sliderRanges = <String, double>{
      '앞목 깊이': 2,
      '진동 길이': 3,
      '옆길이': 5,
      '고무단 길이': 2,
      '목 너비': 1.5,
      '어깨 너비': 3,
      '가슴 너비': 4,
      '소매 길이': 6,
      '소매 고무단 길이': 2,
      '소매 너비': 1,
      '손목 너비': 1.5,
    };

    double range = sliderRanges[label] ?? 4;

    // min, max 계산
    double minVal = defaultValue - range;
    double maxVal = defaultValue + range;

    // 만약 value가 범위를 벗어나면 clamp
    double clampedValue = value.clamp(minVal, maxVal);

    return PatternSlider(
      label: label,
      value: clampedValue,
      min: minVal,
      max: maxVal,
      defaultValue: defaultValue,
      scale: 1.0,
      onChanged: (val) {
        switch (label) {
          case '앞목 깊이':
            vm.setFrontNeckDepth(val);
            break;
          case '진동 길이':
            vm.setArmholeDepth(val);
            break;
          case '옆길이':
            vm.setSideLength(val);
            break;
          case '고무단 길이':
            vm.setBottomBandHeight(val);
            break;
          case '목 너비':
            vm.setNeckWidth(val);
            break;
          case '어깨 너비':
            vm.setShoulderWidth(val);
            break;
          case '가슴 너비':
            vm.setChestWidth(val);
            break;
          case '소매 길이':
            vm.setSleeveLength(val);
            break;
          case '소매 고무단 길이':
            vm.setSleeveBandHeight(val);
            break;
          case '소매 너비':
            vm.setSleeveWidth(val);
            break;
          case '손목 너비':
            vm.setWristWidth(val);
            break;
        }
      },
    );
  }
}
