import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';
import 'package:rate_my_contractor/authentication/login/models/user.dart';
import 'package:rate_my_contractor/authentication/login/models/user_dto.dart';

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

  Future<void> signUp(String email, String password, String userName,
      String firstName, String lastName) async {
    await _userDataProvider.signUp(
        email, password, userName, firstName, lastName);
  }

//change this to a model that has user and authentications status
//way to get the user from the autstate.session.user
//when its not authenticated that user is gonna be null
  Stream<AuthenticationStatus> get status =>
      _userDataProvider.status.map((authState) {
        if (authState.session != null) {
          return AuthenticationStatus.authenticated;
        } else {
          return AuthenticationStatus.unauthenticated;
        }
      });
}
