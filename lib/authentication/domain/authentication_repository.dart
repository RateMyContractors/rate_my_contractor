import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';
import 'package:rate_my_contractor/authentication/login/models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository(this._userDataProvider);
  final UserDataProvider _userDataProvider;

  Future<void> signIn(String email, String password) async {
    await _userDataProvider.signIn(
      email,
      password,
    );
  }

  Future<void> signUp(
    String email,
    String password,
    String userName,
    String firstName,
    String lastName,
    String userType,
  ) async {
    await _userDataProvider.signUp(
      email,
      password,
      userName,
      firstName,
      lastName,
      userType,
    );
  }

  Stream<User> get status => _userDataProvider.status.map((authState) {
        if (authState.session != null) {
          final user = authState.session?.user;
          final metadata = user?.userMetadata;
          final currentuser = User(
            userstatus: AuthenticationStatus.authenticated,
            id: user?.id,
            email: user?.email,
            firstname: metadata!['first_name'] as String?,
            lastname: metadata['last_name'] as String?,
            username: metadata['username'] as String?,
          );
          return currentuser;
        } else {
          const currentuser = User(
            userstatus: AuthenticationStatus.unauthenticated,
          );
          return currentuser;
        }
      });
}
