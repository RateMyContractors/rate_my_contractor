import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  LogOutBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LogOutState()) {
    on<LogOutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onLogoutPressed(
    LogOutPressed event,
    Emitter<LogOutState> emit,
  ) async {
    try {
      await _authenticationRepository.signOut();
      emit(state.copyWith(status: LogOutStateStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: LogOutStateStatus.failure));
    }
  }
}
