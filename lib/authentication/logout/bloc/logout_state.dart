part of 'logout_bloc.dart';

enum LogOutStateStatus { initial, failure, success }

class LogOutState extends Equatable {
  const LogOutState({
    this.status = LogOutStateStatus.initial,
  });
  final LogOutStateStatus status;

  LogOutState copyWith({
    LogOutStateStatus? status,
  }) {
    return LogOutState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];

  @override
  String toString() => 'LogOutState(status: $status)';
}
