import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:timetracking/features/boardview/models/models.dart';
import 'package:timetracking/services/base/hive_service_base.dart';

const bool _debug = !kReleaseMode && true;

class BoardServiceHive implements HiveServiceBase {
  final String boxName;
  BoardServiceHive(this.boxName);
  late final Box<dynamic> _hiveBox;
  void _registerHiveAdapters() {
    Hive.registerAdapter(KColumnAdapter());
    Hive.registerAdapter(KDataAdapter());
    Hive.registerAdapter(KTaskAdapter());
    Hive.registerAdapter(KanbanModelAdapter());
  }

  @override
  Future<Box<dynamic>> init() async {
    _registerHiveAdapters();
    await Hive.openBox<dynamic>(boxName);
    _hiveBox = Hive.box<dynamic>(boxName);
    return _hiveBox;
  }

  @override
  Future<void> add<T>(T value) async {
    try {
      await _hiveBox.add(value);
    } catch (e) {
      debugPrint(' Save value ......... : $value');
    }
  }

  @override
  Future<void> update<T>(int id, T value) async {
    try {
      await _hiveBox.putAt(id, value);
      if (_debug) {
        debugPrint('Hive type   : $id as ${value.runtimeType}');
        debugPrint('Hive saved  : $id as $value');
      }
    } catch (e) {
      debugPrint('Hive save (put) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store id .......... : $id');
      debugPrint(' Save value ......... : $value');
    }
  }

  @override
  Future<void> delete<T>(int key) async {
    try {
      await _hiveBox.deleteAt(key);

      if (_debug) {
        debugPrint('Hive type   : $key as ${key.runtimeType}');
        debugPrint('Hive saved  : $key as $key');
      }
    } catch (e) {
      debugPrint('Hive save (put) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' Save value ......... : $key');
    }
  }

  @override
  Future<void> deleteAll<T>() async {
    try {
      await _hiveBox.clear();
    } catch (e) {
      debugPrint('Hive save (put) ERROR');
      debugPrint(' Error message ...... : $e');
    }
  }

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
  Future<List<T>> loadAll<T>() async {
    try {
      final List<T> loaded = _hiveBox.values.toList() as List<T>;
      return loaded;
    } catch (e) {
 
      return [];
    }
  }

  @override
  Future<int> getLastId() async {
    return _hiveBox.length;
  }
}
