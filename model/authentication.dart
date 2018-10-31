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
