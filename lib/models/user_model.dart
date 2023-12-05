class UserModel {
  final String username;
  final String email;
  final String phone;
  final int orderCount;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // id: json["id"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      orderCount: json["orderCount"] ?? 0
    );
  }
}