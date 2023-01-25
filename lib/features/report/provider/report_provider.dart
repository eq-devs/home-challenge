import 'package:flutter/material.dart';
import 'package:timetracking/constants/store.dart'; 
import 'package:timetracking/features/report/data/repository.dart';
import 'package:timetracking/features/report/model/repo_item_model.dart';

class ReportProvider with ChangeNotifier {
  ReportProvider() {
    _reportItem = Store.items[0];
  }
  final Repository _repository = Repository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ReportItem _reportItem;
  ReportItem get reportItem => _reportItem;

  String _title = '';
  String _body = '';

  void onChangeItem(ReportItem i) {
    _reportItem = i;
    notifyListeners();
  }

  void onInfoChanges({String? t, String? b}) {
    if (t != null) _title = t;
    if (b != null) _body = b;
  }

  void send() async {
    if (formKey.currentState!.validate()) {
      _repository.send(_title, _body);
    } else {
      //do some step
    }
  }
}
