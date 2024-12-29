import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataProvider {
  const UserDataProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  /// Sign in
  Future<void> signIn(String email, String password) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(String email, String password, String userName,
      String firstName, String lastName, String userType) async {
    await _supabaseClient.auth.signUp(email: email, password: password, data: {
      'display_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType
    });
  }

  /// Check Auth
  Stream<AuthState> get status => _supabaseClient.auth.onAuthStateChange;
}
