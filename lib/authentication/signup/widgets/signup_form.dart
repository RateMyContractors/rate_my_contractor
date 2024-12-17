import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('SignUp Failure')),
              );
          }
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const Text('Create your account to get started'),
                    const Padding(padding: EdgeInsets.all(12)),
                    _FirstNameInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _LastNameInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _UsernameInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _EmailInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _PasswordInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _ReEnterPasswordInput(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _SignUpButton(),
                  ],
                ))));
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );
    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    // final isValid = context.select((SignUpBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
        key: const Key('SignUpForm_continue_raisedButton'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 181, 113, 192),
        ),
        // onPressed: isValid
        //     ? () => context.read<SignUpBloc>().add(const SignUpSubmitted())
        //     : null,
        onPressed: () =>
            context.read<SignUpBloc>().add(const SignUpSubmitted()),
        child: const Text('Sign Up',
            style: TextStyle(color: Color.fromARGB(255, 245, 243, 243))));
  }
}

class _ReEnterPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Re-enter Password', border: OutlineInputBorder()),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );
    return TextField(
      key: const Key('signupForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );
    return TextField(
      key: const Key('signupForm_emailInput_textField'),
      onChanged: (email) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email));
      },
      decoration: InputDecoration(
          labelText: 'Email',
          border: const OutlineInputBorder(),
          errorText: displayError != null ? 'invalid email' : null),
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.lastName.displayError,
    );

    return TextField(
      key: const Key('signupForm_lastNameInput_textField'),
      onChanged: (lastName) {
        context.read<SignUpBloc>().add(SignUpLastNameChanged(lastName));
      },
      decoration: InputDecoration(
        labelText: 'LastName',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? 'invalid last name' : null,
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.firstName.displayError,
    );
    return TextField(
      key: const Key('signupForm_firstNameInput_textField'),
      onChanged: (firstName) {
        context.read<SignUpBloc>().add(SignUpFirstNameChanged(firstName));
      },
      decoration: InputDecoration(
        labelText: 'FirstName',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? 'invalid first name' : null,
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.username.displayError,
    );

    return TextField(
      key: const Key('signupForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<SignUpBloc>().add(SignUpUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: 'username',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}
