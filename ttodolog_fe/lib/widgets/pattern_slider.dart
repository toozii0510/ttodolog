import 'package:flutter/material.dart';

class PatternSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const PatternSlider(
      {super.key,
      required this.label,
      required this.value,
      required this.min,
      required this.max,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(1)} cm',
            style: const TextStyle(fontSize: 16)),
        Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
