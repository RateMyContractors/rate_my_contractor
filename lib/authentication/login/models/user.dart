//import 'package:rate_my_contractor/authentication/login/models/user_dto.dart';

class User {
  final String? id;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? username;


  const User(
      {this.id, this.email, this.firstname, this.lastname, this.username});


  @override
  String toString() {
    return 'User{id: $id, email: $email, firstname: $firstname, lastname: $lastname, username: $username}';
  }
}
  
