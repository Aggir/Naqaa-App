part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.isSessionEnded = false});
  final bool isSessionEnded;
  @override
  List<Object> get props => [isSessionEnded];

  AppState copyWith({
    bool? isSessionEnded,
  }) {
    return AppState(
      isSessionEnded: isSessionEnded ?? this.isSessionEnded,
    );
  }
}
