import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timetracking/features/task/model/task_model.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Directory? _dir;

Future<String> getAppDataDir() async {
  if (_dir != null) {
    return _dir!.path;
  } else {
    final Directory dir = await path_provider.getApplicationSupportDirectory();
    _dir = dir;
    return dir.path;
  }
}

DateTime getTimeNow() {
  return DateTime.now();
}

String greetings() {
  var hour = getTimeNow().hour;

  if (hour <= 12) {
    return ('Good\nMorning');
  } else if ((hour > 12) && (hour <= 16)) {
    return ('Good\nAfternoon');
  } else if ((hour > 16) && (hour < 20)) {
    return ('Good\nEvening');
  } else {
    return ('Good\nNight');
  }
}

Future<TimeOfDay?> showTpicker(BuildContext context) async {
  TimeOfDay? selectedTime24Hour = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: false,
        ),
        child: child!,
      );
    },
  );

  return selectedTime24Hour;
}

Future<DateTime?> showDTpicker(BuildContext context, {int? t}) async {
  DateTime? dateTime;

  await showbtmSheet(
      context,
      Column(
        children: [
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
                initialDateTime: DateTime.fromMillisecondsSinceEpoch(
                    t ?? DateTime.now().millisecondsSinceEpoch),
                onDateTimeChanged: (t) {
                  dateTime = t;
                }),
          ),
          CupertinoButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).maybePop(),
          )
        ],
      ));
  return dateTime;
}

Future<void> showbtmSheet(BuildContext context, Widget widget) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (_) {
      return PopWraperWidget(child: widget);
    },
  );
}

Future<void> dialogBuilder(BuildContext context,
    {VoidCallback? yonTap,
    required String title,
    VoidCallback? nonTap,
    String? ylabel,
    String? nlabel}) {
  return showDialog<void>(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actionsOverflowAlignment: OverflowBarAlignment.center,
        alignment: Alignment.center,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ButtonGeneric(label: ylabel ?? 'Yes', onPressed: yonTap),
          const SizedBox(height: 8),
          ButtonGeneric(label: nlabel ?? 'No', onPressed: nonTap),
          const SizedBox(height: 8),
        ],
      );
    },
  );
}

int getUnixT() {
  return getTimeNow().millisecondsSinceEpoch;
}

String convertT2DT(int value) {
  var date = DateTime.fromMillisecondsSinceEpoch(value);
  var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(date);

  return d12;
}

Future<void> copy(String text) async {
  if (text.isNotEmpty) {
    Clipboard.setData(ClipboardData(text: text));
    return;
  } else {
    throw ('Please enter a string');
  }
}

void toast(String str, {ToastGravity? gravity}) {
  Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      fontSize: 16.0);
}

String int2t(int value) {
  int h, m, s;
  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);
  // d = value ~/ (24 * 60 * 60);
  String result = "$h:$m:$s";
  return result;
}

// demo() async {
//   await compute(articleFromJson, json.encode(data[i]));
// } for speed up parse to csv

late Directory appDocDir;
Future<String> getDownloadPath() async {
  try {
    if (Platform.isIOS) {
      appDocDir = await path_provider.getApplicationDocumentsDirectory();
    } else {
      appDocDir = Directory('/storage/emulated/0/Download');
      if (!await appDocDir.exists()) {
        appDocDir = (await path_provider.getExternalStorageDirectory())!;
      }
    }
  } catch (err) {}
  return appDocDir.path;
}

Future<bool> task2Csv(List<dynamic> tasks) async {
  final permission = await Permission.storage.request();
  if (permission.isGranted) {
    String dir = await getDownloadPath();
    List list = [];
    for (var task in tasks) {
      task as TaksModel;
      var json = task.toJson();
      list.add(json);
    }
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("id");
    row.add("title");
    row.add("discrption");
    row.add("hashtag");
    row.add("color");
    row.add("endTime");
    row.add("status");
    row.add("spendTime");
    row.add("addtime");
    row.add("updatetime");
    rows.add(row);
    for (int i = 0; i < list.length; i++) {
      List<dynamic> row = [];
      row.add(list[i]["id"]);
      row.add(list[i]["title"]);
      row.add(list[i]["discrption"]);
      row.add(list[i]["hashtag"]);
      row.add(list[i]["color"]);
      row.add(list[i]["endTime"]);
      row.add(list[i]["status"]);
      row.add(list[i]["spendTime"]);
      row.add(list[i]["addtime"]);
      row.add(list[i]["updatetime"]);
      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows);

    File f = File("$dir/task${getUnixT()}.csv");
    f.writeAsString(csv);

    return true;
  } else {
    toast('No permision');

    return false;
  }
}

void phoneCall(String url) async {
  if (!await launchUrl(Uri(scheme: 'tel', path: url))) {
    toast('Failed', gravity: ToastGravity.BOTTOM);
    throw 'Could not launch $url';
  }
}

Future<void> launchUrls(Uri uri) async {
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalNonBrowserApplication,
  )) {
    toast('Failed', gravity: ToastGravity.BOTTOM);

    throw 'Could not launch ${uri.path}';
  }
}
