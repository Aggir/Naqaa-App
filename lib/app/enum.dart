enum Status {
  initial,
  loading,
  success,
  failure,
  canceled,
}

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isCanceled => this == Status.canceled;
}
