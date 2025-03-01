import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:rate_my_contractor/authentication/login/bloc/login_bloc.dart';
import 'package:rate_my_contractor/authentication/logout/bloc/logout_bloc.dart';

void main() {
  group('testing login state', () {
    test('testing copywith', () {
      const logout = LoginState();
      final copy = logout.copyWith();

      expect(copy.status, FormzSubmissionStatus.initial);
    });
  });
}
