import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationWriteReview>(_onWriteReview);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (user) async {
        switch (user.userstatus) {
          case AuthenticationStatus.unknown:
            return emit(const AuthenticationState.unknown());
          case AuthenticationStatus.authenticated:
            return emit(AuthenticationState.authenticated(user: user));
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
        }
      },
      onError: addError,
    );
  }

  FutureOr<void> _onWriteReview(
    AuthenticationWriteReview event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (user) async {
        switch (user.userstatus) {
          case AuthenticationStatus.unknown:
            return emit(const AuthenticationState.unknown());
          case AuthenticationStatus.authenticated:
            return emit(AuthenticationState.authenticated(user: user));
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
        }
      },
      onError: addError,
    );
  }
}
