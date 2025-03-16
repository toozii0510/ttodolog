import 'package:go_router/go_router.dart';
import 'package:ttodolog_fe/views/LayoutScreen/bottomup_layout_screen.dart';
import 'package:ttodolog_fe/views/LayoutScreen/topdown_layout_screen.dart';
import 'package:ttodolog_fe/views/chart_editor_screen.dart';
import '../views/template_selection_screen.dart';
import '../views/basic_info_screen.dart';
import '../views/measurement_adjust_screen.dart';

class AppRoutes {
  static const templateSelection = '/';
  static const basicInfoInput = '/basic_info';
  static const measurementAdjust = '/measurement_adjust';
  static const topDownLayout = '/top_down_layout';
  static const bottomUpLayout = '/bottom_up_layout';
  static const chartEditor = '/chart_editor';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.templateSelection,
      builder: (context, state) => const TemplateSelectionScreen(), //템플릿선택화면
    ),
    GoRoute(
      path: AppRoutes.basicInfoInput,
      builder: (context, state) => const BasicInfoScreen(), //가슴둘레입력화면
    ),
    GoRoute(
      path: AppRoutes.measurementAdjust,
      builder: (context, state) => const MeasurementAdjustScreen(), //세부치수조정화면
    ),
    GoRoute(
      path: AppRoutes.topDownLayout,
      builder: (context, state) => const TopDownLayoutScreen(), //탑다운 레이아웃
    ),
    GoRoute(
      path: AppRoutes.bottomUpLayout,
      builder: (context, state) => const BottomUpLayoutScreen(), //바텀업 레이아웃
    ),
    GoRoute(
      path: AppRoutes.chartEditor,
      builder: (context, state) => const ChartEditorScreen(), //차트편집화면
    ),
  ],
);
