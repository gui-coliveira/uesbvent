class Usuario {
  String id;
  final String nome;
  final String email;
  final String senha;
  final String celular;
  final String dtNascimento;
  final String? sexo;
  final String curso;
  final String org;

  Usuario({
    this.id = '',
    required this.nome,
    required this.email,
    required this.senha,
    required this.celular,
    required this.dtNascimento,
    required this.sexo,
    required this.curso,
    required this.org,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'senha': senha,
        'celular': celular,
        'dtNascimento': dtNascimento,
        'sexo': sexo,
        'curso': curso,
        'org': org,
      };

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nome: json['nome'],
        email: json['email'],
        senha: json['senha'],
        celular: json['celular'],
        dtNascimento: json['dtNascimento'],
        sexo: json['sexo'],
        curso: json['curso'],
        org: json['org'],
      );
}
