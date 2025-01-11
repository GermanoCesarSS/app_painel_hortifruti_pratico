class UserProfileRequestModel {
  String name;
  String email;
  String? phone;
  String? password;

  UserProfileRequestModel({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  });


  Map<String, dynamic> toJson() => {
        'nome': name,
        'email': email,
        if (phone != null && phone != '')
          'telefone': phone,
        if (password != null && password!.isNotEmpty)
          'password': password,
      };
}
