class UserUpdateModel {
  final String? pwd;
  final String? photoProfile;
  final String? nome;
  final String? email;

  const UserUpdateModel({this.pwd, this.photoProfile, this.nome, this.email});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'password': pwd,
      'imagem': photoProfile,
    };
  }

  @override
  String toString() {
    return 'UsersModel{nome: $nome, email: $email, senha: $pwd, photoPhofile: $photoProfile}';
  }
}
