import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracking/features/home/view/widget/widget.dart';
import 'package:timetracking/utils/util.dart';

class ToCsvBtnWidget extends StatelessWidget {
  final List tasks;
  const ToCsvBtnWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    var scaffoldMessengerState = ScaffoldMessenger.of(context);
    return GestureDetector(
        onTap: () {
          onStartConvert(tasks, scaffoldMessengerState);
        },
        child: BorderBtnWidget(
            selcted: false,
            child: Row(children: const [
              SizedBox(width: 4),
              Text('ToCsv', style: TextStyle(fontSize: 16))
            ])));
  }

  Future<void> onStartConvert(
      List<dynamic> tasks, ScaffoldMessengerState s) async {
    if (tasks.isNotEmpty) {
      s.showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Starting convert'),
            CupertinoActivityIndicator(),
          ],
        ),
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 5),
      ));
      task2Csv(tasks).then((b) {
        Future.delayed(const Duration(milliseconds: 500), () {
          s.removeCurrentSnackBar();
          if (b) {
            toast('Operation completed');
          }
        });
      });
    } else {
      toast('No Data');
    }
  }
}
