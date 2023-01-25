abstract class ThemeServiceBase {
  Future<void> init();
  Future<T> load<T>(String key, T defaultValue);
  Future<void> save<T>(String key, T value);
}

abstract class HiveServiceBase {
  Future<void> init();
  Future<T> load<T>(String key, T defaultValue);
  Future<List<T>> loadAll<T>();
  Future<void> add<T>(T value);
  Future<void> update<T>(int id, T value);
  Future<void> delete<T>(int id);
  Future<void> deleteAll<T>();
  Future<int> getLastId();
}

abstract class BasiServiceBase {
  Future<void> init();
  Future<T> load<T>(String key, T defaultValue);
  Future<void> save<T>(String key, T value);
}
