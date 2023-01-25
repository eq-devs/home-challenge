import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/constants/app_const.dart';
import 'package:timetracking/features/boardview/view/board_page.dart';
import 'package:timetracking/features/boardview/view/kanban_board_page.dart';
import 'package:timetracking/features/settings/setting_page.dart';
import 'package:timetracking/features/task/model/weeke_model.dart';
import 'package:timetracking/features/task/view/detail/detail_page.dart';
import 'package:timetracking/main.dart';
import 'package:timetracking/utils/scroll_behavior.dart';
import 'package:timetracking/utils/theme_controller.dart';
import 'package:timetracking/utils/util.dart';
import 'package:timetracking/features/widgets/widgets.dart';

import 'package:timetracking/features/task/view/task_page.dart';
import 'widget/decord_widget.dart';
import 'widget/tab_widget.dart';

class HomePage extends StatelessWidget {
  final Box<dynamic> tbox;
  final Box<dynamic> bbox;
  final String title;
  final ThemeController controller;
  const HomePage({
    Key? key,
    required this.title,
    required this.controller,
    required this.tbox,
    required this.bbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var tasklistener = tbox.listenable();
    var boardlistener = bbox.listenable();

    return ScrollConfiguration(
      behavior: NoScrollGlowBehavior(),
      child: ScaffoldWidget(
        key: key,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
              width: 66,
              height: 66,
              child: FloatingActionButton(
                splashColor: null,
                focusColor: null,
                hoverColor: null,
                backgroundColor: null,
                foregroundColor: null,
                onPressed: () {
                  _dialogBuilder(context);
                },
                child: const Icon(Icons.add),
              )),
        ),
        action: [
          ValueListenableBuilder<String>(
            valueListenable: shared.emoji,
            builder: (context, value, child) => CircleBtnWidget(
              icon: Icons.login,
              str: value,
              onTap: () {
                showDialog<void>(
                  context: context,
                  useSafeArea: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        titlePadding: const EdgeInsets.only(
                            top: 10, left: 1, right: 1, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        actionsOverflowAlignment: OverflowBarAlignment.center,
                        alignment: Alignment.center,
                        title: SizedBox(
                          height: 300,
                          child: Scrollbar(
                            radius: const Radius.circular(20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              child: Wrap(
                                runAlignment: WrapAlignment.center,
                                spacing: 4,
                                runSpacing: 4,
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: AppConst.emoji
                                    .map((e) => InkWell(
                                          onTap: () {
                                            shared.emojiSetter = e;
                                            Navigator.pop(context);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: SizedBox(
                                              height: 54,
                                              width: 54,
                                              child: Center(
                                                child: Text(
                                                  e,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ));
                  },
                );
              },
            ),
          ),
          CircleBtnWidget(
            icon: Icons.settings,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage(controller: controller)));
            },
          ),
        ],
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,
                  toolbarHeight: mq.size.height * .3,
                  excludeHeaderSemantics: false,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  centerTitle: true,
                  titleSpacing: 20,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        greetings(),
                        style: const TextStyle(fontSize: 63),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Today\'s ${DateFormat('EEEE MMM ,D y').format(DateTime.now())}',
                      )
                    ],
                  ),
                  pinned: true,
                  floating: true,
                  bottom: DecoratedTabBar(
                    tabBar: TabBar(
                        onTap: (value) {
                          shared.indexSetter = value;
                        },
                        tabs: [
                          ValueListenableBuilder<Box<dynamic>>(
                            valueListenable: tasklistener,
                            builder: (context, t, child) =>
                                tab(context, 'Task', t.length.toString()),
                          ),
                          ValueListenableBuilder<Box<dynamic>>(
                              valueListenable: boardlistener,
                              builder: (context, b, child) =>
                                  tab(context, 'Board', b.length.toString()))
                        ]),
                  ),
                ),
              ];
            },
            body: ValueListenableBuilder<int>(
              key: const ValueKey('ValueListenableBuilder'),
              valueListenable: shared.index,
              builder: (context, i, child) => LazyIndexedStack(
                key: const ValueKey('LazyIndexedStack'),
                index: i,
                children: [
                  TaskPage(
                      weekeModel: WeekeModel(), tasklistener: tasklistener),
                  BoardPage(boardlistener: boardlistener),
                ],
              ),
            )),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return dialogBuilder(
    context,
    title: 'New',
    nlabel: 'Board',
    nonTap: () {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const KanbanBoardPage(),
        ),
      );
    },
    ylabel: 'Task',
    yonTap: () {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const TaskDetailPage()),
      );
    },
  );
}
