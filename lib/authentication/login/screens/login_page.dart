import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/bloc/login_bloc.dart';
import 'package:rate_my_contractor/authentication/login/widgets/login_form.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
import 'package:rate_my_contractor/reviews/screens/leaving_reviews_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({required this.route, this.contractor, super.key});
  final Contractor? contractor;
  final String route;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          if (route == '') {
            Navigator.of(context).pop();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute<ReviewFormPage>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: BlocProvider.of<ReviewsBloc>(
                        context,
                      ),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<AuthenticationBloc>(context),
                    ),
                  ],
                  child: ContractorPage(
                    contractor: contractor ?? const Contractor.defaultValue(),
                  ),
                ),
              ),
            );
          }
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
