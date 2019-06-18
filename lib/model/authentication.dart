class LoginRequest {
  String email;
  String password;
  bool isRememberMe = true;

  LoginRequest(this.email, this.password, this.isRememberMe);

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(json['email'], json['password'], json['isRememberMe']);
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'isRememberMe': isRememberMe};
}

class User {
  int id;
  String email;
  String name;

  User(this.id, this.email, this.name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['email'], json['name']);
  }
}

class UserInfo {
  String token;
  User user;

  UserInfo(this.token, this.user);

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(json['token'], User.fromJson(json['user']));
  }
}
