import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/*
authenticated - the user is logged in
unauthenticated - the user isnt logged in 
*/
class AuthenticationRepository {
  const AuthenticationRepository(this._userDataProvider);

  final UserDataProvider _userDataProvider;

  Future<void> signIn(String email, String password) async {
    //future<void> means it wont return nothing just waiting for the call
    await _userDataProvider.signIn(
        email, password); //sending email and password to supabase
  }

  Stream<AuthenticationStatus> get status =>
      _userDataProvider.status.map((authState) {
        if (authState.session != null) {
          //checks if session is active
          _userDataProvider.userInformation();
          return AuthenticationStatus.authenticated;
        } else {
          return AuthenticationStatus.unauthenticated;
        }
      });
}
