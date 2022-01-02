class Failure {
  const Failure();
}

class Maintenance extends Failure {
  const Maintenance(this.errorCode, this.msg);

  final int errorCode;
  final String msg;
}

class ServerError extends Failure {
  const ServerError(this.errorCode, this.msg);

  final int errorCode;
  final String msg;
}

class UnCatchError extends Failure {
  const UnCatchError(this.exception);

  final Exception exception;
}

class FeatureFailure extends Failure {
  final String msg;

  const FeatureFailure({required this.msg});
}
