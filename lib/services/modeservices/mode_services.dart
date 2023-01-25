import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timetracking/services/base/hive_service_base.dart';

const bool _debug = !kReleaseMode && true;

class Modeservices implements BasiServiceBase {
  final String boxName;
  Modeservices(this.boxName);

  late final Box<dynamic> _hiveBox;

  @override
  Future<T> load<T>(String key, T defaultValue) async {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (_debug) {
        debugPrint('Hive type   : $key as ${defaultValue.runtimeType}');
        debugPrint('Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      debugPrint('Hive load (get) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' defaultValue ....... : $defaultValue');
      return defaultValue;
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (_debug) {
        debugPrint('Hive type   : $key as ${value.runtimeType}');
        debugPrint('Hive saved  : $key as $value');
      }
    } catch (e) {
      debugPrint('Hive save (put) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' Save value ......... : $value');
    }
  }

  @override
  Future<void> init() async {
    await Hive.openBox<dynamic>(boxName);
    _hiveBox = Hive.box<dynamic>(boxName);
  }
}
