import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';
import 'package:rate_my_contractor/authentication/signup/models/email.dart';
import 'package:rate_my_contractor/authentication/signup/models/firstname.dart';
import 'package:rate_my_contractor/authentication/signup/models/lastname.dart';
import 'package:rate_my_contractor/authentication/signup/models/password.dart';
import 'package:rate_my_contractor/authentication/signup/models/username.dart';

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
        if (state.status.isSuccess) {
          final snackBar = SnackBar(
            content: const Text(
              'A verification link has been sent to your email account',
            ),
            duration: const Duration(days: 1),
            action: SnackBarAction(
              label: 'Continue',
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<AuthenticationBloc>(
                        context,
                      ),
                      child: const LoginPage(
                        route: '',
                      ),
                    ),
                  ),
                );
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(12)),
              const Expanded(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Expanded(
                child: Text('Create your account to get started'),
              ),
              Expanded(
                child: _ContractorAndUserButton(),
              ),
              const Expanded(
                child: Padding(padding: EdgeInsets.all(12)),
              ),
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
              Expanded(
                child: _SignUpButton(),
              ),
              const Padding(padding: EdgeInsets.all(12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContractorAndUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userType = context.select(
      (SignUpBloc bloc) => bloc.state.userType,
    );
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: userType == 'Contractor'
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              context
                  .read<SignUpBloc>()
                  .add(const SignUpUserType('Contractor'));
            },
            child: Text(
              'Contractor',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: userType == 'User'
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              context.read<SignUpBloc>().add(const SignUpUserType('User'));
            },
            child: Text(
              'User',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ],
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
    return ElevatedButton(
      key: const Key('SignUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => context.read<SignUpBloc>().add(const SignUpSubmitted()),
      child: Text('Sign Up', style: Theme.of(context).textTheme.displaySmall),
    );
  }
}

class _ReEnterPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final originalPassword = context.select(
      (SignUpBloc bloc) => bloc.state.password.value,
    );
    final confirmPassword = context.select(
      (SignUpBloc bloc) => bloc.state.confirmpassword.value,
    );

    final passwordsMatch = originalPassword == confirmPassword;
    return TextField(
      key: const Key('signupForm_ConfirmPasswordInput_textField'),
      onChanged: (password) {
        context.read<SignUpBloc>().add(SignUpConfirmPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Re-enter Password',
        border: const OutlineInputBorder(),
        errorText: !passwordsMatch ? 'Passwords do not match' : null,
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
    String? errormsg;
    if (displayError != null) {
      if (displayError == PasswordValidationError.empty) {
        errormsg = "Password can't be blank";
      } else if (displayError == PasswordValidationError.invalidPassword) {
        errormsg = 'Password length must be more than 8';
      } else if (displayError == PasswordValidationError.noUppercase) {
        errormsg = 'Password must have Uppercase';
      } else if (displayError == PasswordValidationError.noLowercase) {
        errormsg = 'Password must have Lowercase';
      } else if (displayError == PasswordValidationError.noDigit) {
        errormsg = 'Password must have digits';
      } else if (displayError == PasswordValidationError.noSpecialChar) {
        errormsg = 'Password must have special characters';
      }
    } else {
      errormsg = null;
    }
    return Tooltip(
      message:
          ' At least one uppercase letter\n At least one lowercase letter\n '
          'At lease one numeral (0-9) \n At least one symbol (!@#^*_?{}-) \n '
          'Minimum 8 characters',
      child: TextField(
        key: const Key('signupForm_passwordInput_textField'),
        onChanged: (password) {
          context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: const OutlineInputBorder(),
          errorText: displayError != null ? '$errormsg' : null,
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
    String? errormsg;
    if (displayError != null) {
      if (displayError == EmailValidationError.empty) {
        errormsg = "Email can't be blank";
      } else if (displayError == EmailValidationError.invalidEmail) {
        errormsg = 'Email requires an @';
      }
    } else {
      errormsg = null;
    }
    return TextField(
      key: const Key('signupForm_emailInput_textField'),
      onChanged: (email) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email));
      },
      decoration: InputDecoration(
        labelText: 'Email',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? '$errormsg' : null,
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

    String? errormsg;
    if (displayError != null) {
      if (displayError == LastNameValidationError.empty) {
        errormsg = "Last name can't be blank";
      } else if (displayError == LastNameValidationError.invalidLastName) {
        errormsg = 'Last name can only contain alphabetic characters';
      }
    } else {
      errormsg = null;
    }

    return TextField(
      key: const Key('signupForm_lastNameInput_textField'),
      onChanged: (lastName) {
        context.read<SignUpBloc>().add(SignUpLastNameChanged(lastName));
      },
      decoration: InputDecoration(
        labelText: 'Last Name',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? '$errormsg' : null,
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

    String? errormsg;
    if (displayError != null) {
      if (displayError == FirstNameValidationError.empty) {
        errormsg = "First name can't be blank";
      } else if (displayError == FirstNameValidationError.invalidFirstName) {
        errormsg = 'First name can only contain alphabetic characters';
      }
    } else {
      errormsg = null;
    }

    return TextField(
      key: const Key('signupForm_firstNameInput_textField'),
      onChanged: (firstName) {
        context.read<SignUpBloc>().add(SignUpFirstNameChanged(firstName));
      },
      decoration: InputDecoration(
        labelText: 'First Name',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? '$errormsg' : null,
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((SignUpBloc bloc) => bloc.state.username.displayError);
    String? errormsg;
    if (displayError != null) {
      if (displayError == UsernameValidationError.empty) {
        errormsg = "Username can't be blank";
      } else if (displayError == UsernameValidationError.containsSpaces) {
        errormsg = "Username can't contain spaces";
      }
    } else {
      errormsg = null;
    }

    return TextField(
      key: const Key('signupForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<SignUpBloc>().add(SignUpUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: 'username',
        border: const OutlineInputBorder(),
        errorText: displayError != null ? '$errormsg' : null,
      ),
    );
  }
}
