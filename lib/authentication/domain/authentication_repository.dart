import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  const AuthenticationRepository(this._userDataProvider);

  final UserDataProvider _userDataProvider;

  Future<void> signIn(String email, String password) async {
    await _userDataProvider.signIn(email, password);
  }

  Stream<AuthenticationStatus> get status =>
      _userDataProvider.status.map((authState) {
        if (authState.session != null) {
          return AuthenticationStatus.authenticated;
        } else {
          return AuthenticationStatus.unauthenticated;
        }
      });
}
