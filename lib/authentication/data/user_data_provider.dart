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

  Future<void> signUp(String email, String password, String userName,
      String firstName, String lastName) async {
    await _supabaseClient.auth.signUp(email: email, password: password, data: {
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName
    });
  }

  /// Check Auth
  Stream<AuthState> get status => _supabaseClient.auth.onAuthStateChange;

  ///retrieve raw meta data
  Future<void> metaData() async {
    await _supabaseClient.auth.currentUser;
  }
}
