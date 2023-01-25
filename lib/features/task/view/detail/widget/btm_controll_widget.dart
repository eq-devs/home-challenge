import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracking/features/task/view/detail/provider/task_provider.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/util.dart';

class BtmControllWidget extends StatelessWidget {
  const BtmControllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var provider = context.watch<TaskProvider>();
    final bool isDone = provider.taksModel.status == 'Done';

    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isDone
            ? MediaQuery.of(context).size.height * .1
            : MediaQuery.of(context).size.height * .17,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: themeData.inputDecorationTheme.fillColor),
        child:
            isDone ? _buildDone(provider.time.value) : _buildActive(provider));
  }

  Widget _buildDone(int t) {
    return Center(
        child: Text('⏳${int2t(t)}', style: const TextStyle(fontSize: 25.0)));
  }

  Widget _buildActive(TaskProvider provider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20.0),
        ValueListenableBuilder<int>(
          valueListenable: provider.time,
          builder: (context, t, child) =>
              Text(int2t(t), style: const TextStyle(fontSize: 25.0)),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: provider.play,
            builder: (context, play, child) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleBtnWidget(
                    color: play ? Colors.blue : Colors.red,
                    onTap: () {
                      provider.onPlay(play);
                    },
                    icon: !play ? Icons.play_arrow : Icons.pause),
                const SizedBox(width: 20.0),
                CircleBtnWidget(
                    color: Colors.green,
                    onTap: () {
                      dialogBuilder(context, title: 'Set done?', nonTap: () {
                        Navigator.pop(context);
                      }, yonTap: () {
                        provider.onDone().whenComplete(() {
                          Navigator.pop(context);
                        });
                      });
                    },
                    icon: Icons.check),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
