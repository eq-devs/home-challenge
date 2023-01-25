import 'package:flutter/material.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/util.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        body: ListviewWidget(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                SizedBox(height: 10),
                Text('Estai Qargabai'),
                SizedBox(height: 8),
                SelectionArea(
                  child: Text(
                      'I\'m currently specialized in Flutter development, looking for more efficient ways to develop mobile applications.'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SelectionArea(
              child: Column(
                children: const [
                  SizedBox(height: 10),
                  Text('About this app'),
                  SizedBox(height: 8),
                  Text(
                      '''home challenge task build a time tracking app, main functions :\n① A kanban board for tasks.\n② A timer function that allows users to start and stop tracking the time spent on each task.\n⓷ A history of completed tasks, including the time spent on each task and the date it was completed.\n④ A way to export data to CSV file.
                      '''),
                  Text('App version:1.0.0'),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Social'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _item('Github', 'https://github.com/Ekmadish',
                      Icons.open_in_new),
                  _item(
                      'Email',
                      'mailto:estaykargabay@gmail.com?subject=Hello&body=...',
                      Icons.email_outlined)
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    ));
  }
}

Widget _item(String s, String link, IconData icon) {
  return TextButton.icon(
    style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    icon: Icon(
      icon,
      color: Colors.blue,
    ),
    onPressed: () {
      launchUrls(Uri.parse(link));
    },
    label: Text(
      s,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,
        fontSize: 16,
      ),
    ),
  );
}
