class UserModel {
  String name;
  String password;

  UserModel(this.name, this.password);

  Map<String, dynamic> toMap() {
    return {'name': name, 'password': password};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'],
      map['password'],
    );
  }
}
