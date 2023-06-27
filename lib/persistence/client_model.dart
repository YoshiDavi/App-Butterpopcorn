class UsersModel {
  final int id;
  final String nome;
  final String pwd;
  final String email;
  final String photoProfile;

  const UsersModel(
      {required this.id,
      required this.nome,
      required this.pwd,
      required this.email,
      required this.photoProfile});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'password': pwd,
      'email': email,
      'imagem': photoProfile,
    };
  }

  @override
  String toString() {
    return 'UsersModel{id: $id, name: $nome, senha: $pwd, email: $email, photoPhofile: $photoProfile}';
  }
}
