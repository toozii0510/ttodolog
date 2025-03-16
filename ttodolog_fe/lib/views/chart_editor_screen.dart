import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ttodolog_fe/%08viewmodels/measurement_viewmodel.dart';

class ChartEditorScreen extends ConsumerStatefulWidget {
  const ChartEditorScreen({super.key});

  @override
  ConsumerState<ChartEditorScreen> createState() => _ChartEditorScreenState();
}

class _ChartEditorScreenState extends ConsumerState<ChartEditorScreen> {
  List<List<String>> grid = []; // 차트 데이터 저장

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    final measurementState = ref.read(measurementViewModelProvider);
    int rows = (measurementState.sideLength * 4).toInt();
    int cols = (measurementState.chestWidth * 4).toInt();
    grid = List.generate(rows, (_) => List.generate(cols, (_) => ' ')); // 빈 데이터
  }

  void _updateGrid(int row, int col, String value) {
    setState(() {
      grid[row][col] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("차트 편집기")),
      body: Column(
        children: [
          /// **✅ 차트 그리드 표시**
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: grid.isNotEmpty ? grid[0].length : 10,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: grid.length * (grid.isNotEmpty ? grid[0].length : 10),
              itemBuilder: (context, index) {
                int row = index ~/ grid[0].length;
                int col = index % grid[0].length;
                return GestureDetector(
                  onTap: () => _updateGrid(row, col, 'X'), // 클릭하면 "X" 입력
                  child: Container(
                    color: grid[row][col] == 'X' ? Colors.blue : Colors.white,
                    child: Center(child: Text(grid[row][col])),
                  ),
                );
              },
            ),
          ),

          /// **✅ 저장 버튼**
          ElevatedButton(
            onPressed: () {
              // TODO: 차트 데이터 저장 처리
            },
            child: const Text("저장"),
          ),
        ],
      ),
    );
  }
}
