import 'package:flutter/material.dart';

class PatternSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final double defaultValue;
  final double scale;
  final ValueChanged<double> onChanged;

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
  Widget build(BuildContext context) {
    // 표시용 값
    final displayValue = (value * scale).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $displayValue cm'),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Min: ${min.toStringAsFixed(1)}'),
            ElevatedButton(
              onPressed: () => onChanged(defaultValue),
              child: const Text('Reset'),
            ),
            Text('Max: ${max.toStringAsFixed(1)}'),
          ],
        ),
      ],
    );
  }
}
