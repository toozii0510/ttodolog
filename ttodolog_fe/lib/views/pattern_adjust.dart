import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiPatternAdjuster extends StatefulWidget {
  const MultiPatternAdjuster({super.key});

  @override
  _MultiPatternAdjusterState createState() => _MultiPatternAdjusterState();
}

class _MultiPatternAdjusterState extends State<MultiPatternAdjuster> {
  // 📌 조정 가능한 치수들
  double frontNeckDepth = 7.0;
  double armholeDepth = 19.0;
  double sideLength = 30.0;
  double bottomBandHeight = 5.0;
  double neckWidth = 17.3;
  double shoulderWidth = 34.0;
  double chestWidth = 47.0;
  double sleeveLength = 51.0;
  double sleeveBottomBand = 5.0;
  double sleeveWidth = 16.0;
  double wristWidth = 8.0;

  /// **📌 SVG 패턴 생성 함수**
  String generatePatternSVG(String type, double offsetX) {
    const double scale = 6.0; // 크기 조정
    const double baseY = 100.0; // 상단 여백

    double halfNeckWidth = (neckWidth / 2) * scale;
    double centerX = offsetX + 250.0; // 패턴 위치 조정
    double baseNeckLeftX = centerX - halfNeckWidth;
    double baseNeckRightX = centerX + halfNeckWidth;
    double shoulderLeftX = centerX - (shoulderWidth / 2) * scale;
    double shoulderRightX = centerX + (shoulderWidth / 2) * scale;

    double armholeY = baseY + armholeDepth * scale;
    double hemY = baseY + (sideLength + armholeDepth) * scale;
    double bandTopY = hemY - bottomBandHeight * scale;

    double chestLeftX = centerX - (chestWidth / 2) * scale;
    double chestRightX = centerX + (chestWidth / 2) * scale;
    double neckCurveControlY = baseY + frontNeckDepth * scale;

    return '''
    <svg width="1200" height="1000" viewBox="0 0 1200 1000" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate($offsetX, 100)">
        <path d="M $baseNeckLeftX,$baseY 
                Q $centerX,$neckCurveControlY $baseNeckRightX,$baseY 
                L $shoulderRightX,$baseY 
                L $shoulderLeftX,$baseY 
                Q ${shoulderLeftX - 10},$armholeY $chestLeftX,$armholeY 
                L $chestLeftX,$hemY 
                L $chestRightX,$hemY 
                L $chestRightX,$armholeY 
                Q ${shoulderRightX + 10},$armholeY $shoulderRightX,$baseY 
                Z"
              stroke="black" fill="none" stroke-width="2"/>
      </g>
    </svg>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('도안 조정 화면')),
      body: Column(
        children: [
          // 📌 **앞판, 뒷판, 소매 배치**
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.string(generatePatternSVG("back", 0),
                      fit: BoxFit.contain),
                  SvgPicture.string(generatePatternSVG("front", 400),
                      fit: BoxFit.contain),
                  SvgPicture.string(generatePatternSVG("sleeve", 800),
                      fit: BoxFit.contain),
                ],
              ),
            ),
          ),

          // 📌 **슬라이더 UI (한 줄에 2개씩)**
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildSlider('앞목 깊이 A', frontNeckDepth, 5, 9,
                    (val) => setState(() => frontNeckDepth = val)),
                _buildSlider('진동 깊이 B', armholeDepth, 17, 21,
                    (val) => setState(() => armholeDepth = val)),
                _buildSlider('옆길이 C', sideLength, 25, 35,
                    (val) => setState(() => sideLength = val)),
                _buildSlider('가슴 너비 G', chestWidth, 45, 49,
                    (val) => setState(() => chestWidth = val)),
                _buildSlider('소매 길이 J', sleeveLength, 46, 56,
                    (val) => setState(() => sleeveLength = val)),
                _buildSlider('손목 너비 M', wristWidth, 7, 9,
                    (val) => setState(() => wristWidth = val)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **📌 슬라이더 UI**
  Widget _buildSlider(String label, double value, double min, double max,
      ValueChanged<double> onChanged) {
    return SizedBox(
      width: 250, // 슬라이더 너비 조정
      child: Column(
        children: [
          Text('$label: ${value.toStringAsFixed(1)} cm',
              style: const TextStyle(fontSize: 16)),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
