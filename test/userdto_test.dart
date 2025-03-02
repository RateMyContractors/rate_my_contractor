import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/authentication/login/models/user.dart';

void main() {
  group('testing user model', () {
    test('testing toString', () {
      const fakeUser = User(
        id: 'test',
        email: 'test',
        firstname: 'test',
        lastname: 'test',
        username: 'test',
        usertype: 'test',
      );
      expect(
          fakeUser.toString(),
          'User{status: AuthenticationStatus.unknown,id: test,email: test, '
          'firstname: test,lastname: test, '
          'username:test,usertype:test}');
    });
  });
}
