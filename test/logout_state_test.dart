import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/authentication/logout/bloc/logout_bloc.dart';

void main() {
  group('testing logout state', () {
    test('testing copywith', () {
      const logout = LogOutState();
      final copy = logout.copyWith(status: LogOutStateStatus.success);

      expect(copy.status, LogOutStateStatus.success);
    });
  });
}
