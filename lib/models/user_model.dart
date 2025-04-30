class UserModel {
  String email;
  String password;
  String? userName;

  UserModel({required this.email, required this.password, this.userName});

  UserModel copyWith({String? userName, String? email, String? password}) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
    );
  }
}
