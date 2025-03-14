import 'package:go_router/go_router.dart';
import '../views/template_selection_screen.dart';
import '../views/basic_info_screen.dart';
import '../views/measurement_adjust_screen.dart';

class AppRoutes {
  static const templateSelection = '/';
  static const basicInfoInput = '/basic_info';
  static const measurementAdjust = '/measurement_adjust';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.templateSelection,
      builder: (context, state) => const TemplateSelectionScreen(),
    ),
    GoRoute(
      path: AppRoutes.basicInfoInput,
      builder: (context, state) => const BasicInfoScreen(),
    ),
    GoRoute(
      path: AppRoutes.measurementAdjust,
      builder: (context, state) => const MeasurementAdjustScreen(),
    ),
  ],
);
