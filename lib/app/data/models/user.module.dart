class UserModel {
  String name;
  String email;
  String? phone;

  UserModel({
    required this.name,
    required this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id_admin')) {
      return UserModel(
        name: json['nome'],
        email: json['email'],
      );
    } else {
      return UserModel(
        name: json['nome'],
        email: json['email'],
        phone: json['telefone'],
      );
    }
  }
}
