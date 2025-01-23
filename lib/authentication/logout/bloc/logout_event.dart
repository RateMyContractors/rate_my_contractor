part of 'logout_bloc.dart';

sealed class LogOutEvent extends Equatable {
  const LogOutEvent();
}

final class LogOutPressed extends LogOutEvent {
  const LogOutPressed();

  @override
  List<Object?> get props => [];
}
