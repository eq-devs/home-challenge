import 'package:flutter/material.dart';
import 'package:timetracking/features/task/model/task_model.dart';
import 'package:timetracking/features/task/view/detail/detail_page.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/util.dart';

class TaskItemWidget extends StatelessWidget {
  final TaksModel item;
  const TaskItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitchWidget(
      child: GestureDetector(
        key: ValueKey(item.hashCode),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => TaskDetailPage(item: item)));
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Color(item.color!),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: CircleAvatar(child: Text(item.mode ?? '😄')),
                  title: Text(item.title ?? ''),
                  subtitle: Text(
                    item.discrption ?? '',
                    maxLines: 1,
                  ),
                  minLeadingWidth: 0,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      text: 'Ending time ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: convertT2DT(item.endTime!),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            )),
      ),
    );
  }
}
