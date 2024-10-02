class Destino{
  int? id_destino;
  int? id_cliente;
  String? destino;

  Destino({
    this.id_destino,
    this.id_cliente,
    this.destino
  });

  @override
  String toString() {
    return 'Destino { destino: $destino, id_cliente: $id_cliente, id_destino: $id_destino }';
  }

  factory Destino.fromMap(Map<String, dynamic> map) => Destino(
    id_destino: map['id_destino'],
    id_cliente: map['id_cliente'],
    destino: map['destino'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id_destino": id_destino,
    "id_cliente": id_cliente,
    "destino": destino
  };
}