class Inscricao {
  String id;
  final String usuarioId;
  final String eventoId;
  final String presente;

  Inscricao({
    this.id = '',
    required this.usuarioId,
    required this.eventoId,
    required this.presente,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuarioId': usuarioId,
        'eventoId': eventoId,
        'presente': presente,
      };

  static Inscricao fromJson(Map<String, dynamic> json) => Inscricao(
        id: json['id'],
        usuarioId: json['usuarioId'],
        eventoId: json['eventoId'],
        presente: json['presente'],
      );
}
