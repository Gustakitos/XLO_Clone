enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  User(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.type = UserType.PARTICULAR});

  String name;
  String email;
  String phone;
  String password;
  UserType type;
}
