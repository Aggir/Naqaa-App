import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  setIsSessionEnded(bool isSessionEnded) {
    emit(state.copyWith(isSessionEnded: isSessionEnded));
  }
}
