import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';
import 'package:rate_my_contractor/authentication/signup/widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => SignUpBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const SignupForm(),
        ),
      ),
    );
  }
}
