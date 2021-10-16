typedef Lazy<T> = T Function();

/// Represents a value of one of two possible types.
/// Instances of [Either] are either an instance of [FailValue] or [SuccessValue].
///
/// [FailValue] is used for "failure".
/// [SuccessValue] is used for "success".
abstract class Either<Fail, Success> {
  const Either();

  /// Represents the left side of [Either] class which by convention is a "Failure".
  bool get isFail => this is FailValue<Fail, Success>;

  /// Represents the right side of [Either] class which by convention is a "Success"
  bool get isSuccess => this is SuccessValue<Fail, Success>;

  /// Get [FailValue] value, may throw an exception when the value is [SuccessValue]
  Fail get fail => this.fold<Fail>(
          (value) => value,
          (right) => throw Exception(
          'Illegal use. You should check isLeft() before calling'));

  /// Get [SuccessValue] value, may throw an exception when the value is [FailValue]
  Success get success => this.fold<Success>(
          (left) => throw Exception(
          'Illegal use. You should check isRight() before calling'),
          (value) => value);

  /// Transform values of [FailValue] and [SuccessValue]
  Either<TL, TR> either<TL, TR>(
      TL Function(Fail left) fnL, TR Function(Success right) fnR);

  /// Transform value of [SuccessValue] when transformation may be finished with an error
  Either<Fail, TR> then<TR>(Either<Fail, TR> Function(Success right) fnR);

  /// Transform value of [SuccessValue] when transformation may be finished with an error
  Future<Either<Fail, TR>> asyncThen<TR>(
      Future<Either<Fail, TR>> Function(Success right) fnR);

  /// Transform value of [SuccessValue]
  Either<Fail, TR> map<TR>(TR Function(Success right) fnR);

  /// Transform value of [FailValue]
  Either<TL, Success> mapLeft<TL>(TL Function(Fail left) fnL);

  /// Transform value of [SuccessValue]
  Future<Either<Fail, TR>> asyncMap<TR>(Future<TR> Function(Success right) fnR);

  /// Fold [FailValue] and [SuccessValue] into the value of one type
  T fold<T>(T Function(Fail left) fnL, T Function(Success right) fnR);

  /// Swap [FailValue] and [SuccessValue]
  Either<Success, Fail> swap() => fold((left) => SuccessValue(left), (right) => FailValue(right));

  /// Constructs a new [Either] from a function that might throw
  static Either<L, R> tryCatch<L, R, Err>(
      L Function(Err err) onError, R Function() fnR) {
    try {
      return SuccessValue(fnR());
    } on Err catch (e) {
      return FailValue(onError(e));
    }
  }

  /// If the condition is satify then return [rightValue] in [SuccessValue] else [leftValue] in [FailValue]
  static Either<L, R> cond<L, R>(bool test, L leftValue, R rightValue) =>
      test ? SuccessValue(rightValue) : FailValue(leftValue);

  /// If the condition is satify then return [rightValue] in [SuccessValue] else [leftValue] in [FailValue]
  static Either<L, R> condLazy<L, R>(
      bool test, Lazy<L> leftValue, Lazy<R> rightValue) =>
      test ? SuccessValue(rightValue()) : FailValue(leftValue());

}

/// Used for "failure"
class FailValue<L, R> extends Either<L, R> {
  final L value;

  const FailValue(this.value);

  @override
  Either<TL, TR> either<TL, TR>(
      TL Function(L left) fnL, TR Function(R right) fnR) {
    return FailValue<TL, TR>(fnL(value));
  }

  @override
  Either<L, TR> then<TR>(Either<L, TR> Function(R right) fnR) {
    return FailValue<L, TR>(value);
  }

  @override
  Future<Either<L, TR>> asyncThen<TR>(
      Future<Either<L, TR>> Function(R right) fnR) {
    return Future.value(FailValue<L, TR>(value));
  }

  @override
  Either<L, TR> map<TR>(TR Function(R right) fnR) {
    return FailValue<L, TR>(value);
  }

  @override
  Either<TL, R> mapLeft<TL>(TL Function(L left) fnL) {
    return FailValue<TL, R>(fnL(value));
  }

  @override
  Future<Either<L, TR>> asyncMap<TR>(Future<TR> Function(R right) fnR) {
    return Future.value(FailValue<L, TR>(value));
  }

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnL(value);
  }
}

/// Used for "success"
class SuccessValue<L, R> extends Either<L, R> {
  final R value;

  const SuccessValue(this.value);

  @override
  Either<TL, TR> either<TL, TR>(
      TL Function(L left) fnL, TR Function(R right) fnR) {
    return SuccessValue<TL, TR>(fnR(value));
  }

  @override
  Either<L, TR> then<TR>(Either<L, TR> Function(R right) fnR) {
    return fnR(value);
  }

  @override
  Future<Either<L, TR>> asyncThen<TR>(
      Future<Either<L, TR>> Function(R right) fnR) {
    return fnR(value);
  }

  @override
  Either<L, TR> map<TR>(TR Function(R right) fnR) {
    return SuccessValue<L, TR>(fnR(value));
  }

  @override
  Either<TL, R> mapLeft<TL>(TL Function(L left) fnL) {
    return SuccessValue<TL, R>(value);
  }

  @override
  Future<Either<L, TR>> asyncMap<TR>(Future<TR> Function(R right) fnR) {
    return fnR(value).then((value) => SuccessValue<L, TR>(value));
  }

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnR(value);
  }
}