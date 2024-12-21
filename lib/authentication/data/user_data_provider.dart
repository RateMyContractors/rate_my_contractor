import 'package:rate_my_contractor/authentication/login/models/user_dto.dart';
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
