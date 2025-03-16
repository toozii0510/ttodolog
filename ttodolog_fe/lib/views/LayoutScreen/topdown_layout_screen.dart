import 'package:flutter/material.dart';

class TopDownLayoutScreen extends StatelessWidget {
  const TopDownLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("탑다운 도안 레이아웃")),
      body: const Center(
        child: Text(
          "탑다운 방식의 도안 레이아웃이 표시됩니다.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
