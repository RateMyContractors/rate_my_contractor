import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataProvider {
  const UserDataProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  /// Sign in
  /// doesnt return a value pass email and password and call supaabse and sighin with password
  Future<void> signIn(String email, String password) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  ///using _supabaseClient.auth. we are now able to retrieve the user information
  User? userInformation() {
    return _supabaseClient.auth.currentUser;
  }

  /// Check Auth
  Stream<AuthState> get status => _supabaseClient.auth.onAuthStateChange;
}
