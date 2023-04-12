class Inscricao {
  String id;
  final String usuarioId;
  final String eventoId;

  Inscricao({
    this.id = '',
    required this.usuarioId,
    required this.eventoId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuarioId': usuarioId,
        'eventoId': eventoId,
      };

  static Inscricao fromJson(Map<String, dynamic> json) => Inscricao(
        id: json['id'],
        usuarioId: json['usuarioId'],
        eventoId: json['eventoId'],
      );
}
