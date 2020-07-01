abstract class DataResult<T> {
  DataResult._();

  factory DataResult.success(T data) = Success<T>;
  factory DataResult.failure(Exception exception) = Failure<T>;

  bool isFailure() => this is Failure;

  T get data => (this as Success).data;

  Exception get exception => (this as Failure).exception;
}

class Success<T> extends DataResult<T> {
  final T data;
  Success(this.data) : super._();
}

class Failure<T> extends DataResult<T> {
  final Exception exception;
  Failure(this.exception) : super._();
}
