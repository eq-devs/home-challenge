import 'package:flutter/material.dart';
import 'package:timetracking/features/widgets/widgets.dart';

@immutable
class ScaffoldWidget extends StatelessWidget {
  final Widget body;
  final List<Widget>? action;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const ScaffoldWidget(
      {super.key,
      required this.body,
      this.action,
      this.floatingActionButtonLocation,
      this.floatingActionButton,
      this.floatingActionButtonAnimator});

  @override
  Widget build(BuildContext context) {
    // var themeData = Theme.of(context);
    // var brightness = themeData.brightness;
    // bool isDarkMode = brightness == Brightness.dark;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    return Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: kToolbarHeight + 40,
          automaticallyImplyLeading: false,
          title: RepaintBoundary(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: !canPop
                    ? []
                    : [
                        CircleBtnWidget(
                            onTap: () {
                              Navigator.maybePop(context);
                            },
                            icon: Icons.arrow_back_ios_new_outlined),
                      ]
                  ..addAll(action ?? [])),
          ),
        ),
        body: SafeArea(child: body));
  }
}
