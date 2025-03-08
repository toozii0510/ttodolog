import 'package:flutter/material.dart';

class PatternSlider extends StatefulWidget {
  final String label;
  final double value; // ✅ 부모에서 받은 값 (이미 scale 적용된 값)
  final double min;
  final double max;
  final double defaultValue;
  final double scale;
  final Function(double) onChanged;

  const PatternSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.defaultValue,
    required this.scale,
    required this.onChanged,
  });

  @override
  _PatternSliderState createState() => _PatternSliderState();
}

class _PatternSliderState extends State<PatternSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value / widget.scale; // ✅ Scale을 고려하여 초기 값 설정
  }

  @override
  void didUpdateWidget(covariant PatternSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _currentValue = widget.value / widget.scale; // ✅ Scale 적용된 값으로 업데이트
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}: ${(_currentValue * widget.scale).toStringAsFixed(1)} cm",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _currentValue,
          min: widget.min / widget.scale, // ✅ Scale 적용된 최소값
          max: widget.max / widget.scale, // ✅ Scale 적용된 최대값
          divisions: ((widget.max - widget.min) / 0.1).toInt().clamp(1, 100),
          label: (_currentValue * widget.scale)
              .toStringAsFixed(1), // ✅ 실제 cm 단위 표시
          onChanged: (val) {
            setState(() {
              _currentValue = val; // ✅ UI 상태 업데이트
            });
            widget.onChanged(
                _currentValue * widget.scale); // ✅ 부모에는 scale 적용된 값 전달
          },
        ),
        Text(
          "현재 값: ${(_currentValue * widget.scale).toStringAsFixed(1)} cm",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
