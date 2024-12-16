import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';


class SignupForm extends StatelessWidget{
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _FirstNameInput(),
            const Padding(padding: EdgeInsets.all(12)),            
            _LastNameInput(),
            const Padding(padding: EdgeInsets.all(12)),            
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _SignUpButton(),
          ],
        ),
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
        labelText: 'email',
        errorText: displayError != null ? 'invalid email' : null,
      ),
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
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
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
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'firstName',
        errorText: displayError != null ? 'invalid first name' : null,
      ),
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
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'lastName',
        errorText: displayError != null ? 'invalid last name' : null,
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
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'username',
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((SignUpBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('SignUpForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignUpBloc>().add(const SignUpSubmitted())
          : null,
      child: const Text('SignUp'),
    );
  }
}



