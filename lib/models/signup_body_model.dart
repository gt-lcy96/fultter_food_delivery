class SignUpBody {
  String username;
  String phone;
  String email;
  String password;
  SignUpBody({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toJsonModified() {
    return {
      "user": {
        "username": username,
        "email": email,
        "password": password,
      },
      "phone": phone,
    };
  }
}