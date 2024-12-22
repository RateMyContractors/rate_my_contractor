import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/bloc/login_bloc.dart';
import 'package:rate_my_contractor/authentication/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (listenercontext, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocProvider(
            create: (context) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
