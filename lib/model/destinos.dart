class Destino{
  int? id_destino;
  String? destino;

  Destino({
    this.id_destino,
    this.destino
  });

  @override
  String toString() {
    return 'Destino { destino: $destino, id_destino: $id_destino }';
  }

  factory Destino.fromMap(Map<String, dynamic> map) => Destino(
    id_destino: map['id_destino'],
    destino: map['destino'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id_destino": id_destino,
    "destino": destino
  };
}