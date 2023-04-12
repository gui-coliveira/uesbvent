class Evento {
  String id;
  final String title;
  final String descricao;
  //String curso;

  Evento({
    this.id = '',
    required this.title,
    required this.descricao,
    //this.curso = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descricao': descricao,
        //curso': curso,
      };

  static Evento fromJson(Map<String, dynamic> json) => Evento(
        id: json['id'],
        title: json['title'],
        descricao: json['descricao'],
        //curso: json['curso'],
      );
}
