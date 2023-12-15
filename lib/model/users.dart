class User {
  late String username;
  late String email;

  User(this.username, this.email);

  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email};
  }
}
