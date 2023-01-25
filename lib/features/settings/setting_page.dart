import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timetracking/constants/app_color.dart';
import 'package:timetracking/features/about/about_page.dart';
import 'package:timetracking/features/report/view/report_screen.dart';
import 'package:timetracking/features/widgets/theme_popup_menu.dart';
import 'package:timetracking/utils/theme_controller.dart';
import 'package:timetracking/features/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  final ThemeController controller;
  const SettingsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        body: ListviewWidget(
      padding: const EdgeInsets.symmetric(horizontal: 8)
          .copyWith(bottom: 20, top: 20),
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlexThemeModeSwitch(
                  themeMode: controller.themeMode,
                  onThemeModeChanged: controller.setThemeMode,
                  flexSchemeData:
                      AppColor.customSchemes[controller.schemeIndex],
                  optionButtonBorderRadius: controller.useSubThemes ? 12 : 4,
                ),
                const SizedBox(height: 8),
                ThemePopupMenu(
                  contentPadding: EdgeInsets.zero,
                  schemeIndex: controller.schemeIndex,
                  onChanged: controller.setSchemeIndex,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ReportPage()));
            },
            trailing:
                const CircleAvatar(child: Icon(Icons.bug_report_outlined)),
            title: const Text('Reposrt'),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutMePage()));
            },
            trailing:
                const CircleAvatar(child: Icon(Icons.psychology_outlined)),
            title: const Text('About'),
          ),
        ),
      ],
    ));
  }
}
