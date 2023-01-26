import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timetracking/constants/app_color.dart';
import 'package:timetracking/features/home/view/home_page.dart';
import 'package:timetracking/services/taskservices/task_service_hive.dart';
import 'package:timetracking/utils/theme_controller.dart';
import 'package:timetracking/utils/util.dart';

import 'features/shared/shared.dart';
import 'services/boardservices/board_service_hive.dart';
import 'services/themeservices/theme_service_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerSingletons();
  await _bootstrap();
  runApp(const AppRoot());
}

late ThemeServiceHive _themeServiceHive;
late ThemeController _themeController;
final _getIt = GetIt.I;
TaskServiceHive get taskService => _getIt.get<TaskServiceHive>();
BoardServiceHive get boardService => _getIt.get<BoardServiceHive>();
Shared get shared => _getIt.get<Shared>();

void _registerSingletons() {
  _getIt.registerLazySingleton<TaskServiceHive>(() => TaskServiceHive('tasks'));
  _getIt.registerLazySingleton<BoardServiceHive>(
    () => BoardServiceHive('board'),
  );
  _getIt.registerLazySingleton<Shared>(
    () => Shared(),
    dispose: (param) {
      shared.dispose();
    },
  );
}

Future<void> _bootstrap() async {
  final String appDataDir = await getAppDataDir();
  Hive.init(appDataDir);
  _themeServiceHive = ThemeServiceHive('themeMode');
  await _themeServiceHive.init();
  _themeController = ThemeController(_themeServiceHive);
  await _themeController.loadAll();
}

//widgets part
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: FlexThemeData.light(
          colors: AppColor.customSchemes[_themeController.schemeIndex].light,
        ),
        darkTheme: FlexThemeData.dark(
          colors: AppColor.customSchemes[_themeController.schemeIndex].dark,
        ),
        themeMode: _themeController.themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<void> _init(BuildContext context) async {
    Box<dynamic> b = await boardService.init();
    Box<dynamic> t = await taskService.init();

    Future<void>.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              tbox: t,
              bbox: b,
              title: 'Demo',
              controller: _themeController,
            ),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Image.asset('assets/images/logo.png',
                    filterQuality: FilterQuality.low, scale: 4)
                .animate()
                .scale(
                    end: .7,
                    begin: 1,
                    duration: const Duration(milliseconds: 600))
                .callback(callback: (_) {
          _init(context);
        })));
  }
}
