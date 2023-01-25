import 'package:flutter/material.dart';
import 'package:timetracking/constants/store.dart';
import 'package:timetracking/services/modeservices/mode_services.dart';

import 'baseshared.dart';

class Shared implements BaseShared {
  late final ValueNotifier<int> _index;
  late final ValueNotifier<String> _emoji;
  late Modeservices _modeservices;
  Shared() {
    init();
  }
  ValueNotifier<String> get emoji => _emoji;
  ValueNotifier<int> get index => _index;
  set indexSetter(int i) {
    index.value = i;
  }

  set emojiSetter(String s) {
    _emoji.value = s;
    _modeservices.save<String>(Store.mode, s);
  }

  @override
  void init() async {
    _index = ValueNotifier(0);
    _emoji = ValueNotifier('❓');

    _modeservices = Modeservices(Store.mode);
    await _modeservices.init();
    var s = await _modeservices.load<String>(Store.mode, '❓');
    _emoji.value = s;
  }

  @override
  void dispose() {
    _index.dispose();
    _emoji.dispose();
  }
}
