class Result<T> {
  Result._({this.value, this.error});

  factory Result.value(T value) => Result._(value: value);
  factory Result.error(Object error) => Result._(error: error);

  final T value;
  final Object error;

  bool get isValue => error == null;
  bool get isError => error != null;
}
