abstract class Model<T> {
  Map toJson();
  T fromJson();
  T copyWith();
}
