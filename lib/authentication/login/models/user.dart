import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';

class User {
  const User({
    this.userstatus = AuthenticationStatus.unknown,
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.username,
  });
  final AuthenticationStatus userstatus;
  final String? id;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? username;

  @override
  String toString() {
    return 'User{status: $userstatus, id: $id, email: $email, '
        'firstname: $firstname, lastname: $lastname, username: $username}';
  }
}
