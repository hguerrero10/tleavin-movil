class Modelo{
  int? id_modelo;
  int? id_cliente;
  String? modelo;

  Modelo({
    this.id_modelo,
    this.id_cliente,
    this.modelo
  });

  @override
  String toString() {
    return 'Modelo { id_cliente: $id_cliente, modelo: $modelo, id_modelo: $id_modelo }';
  }

  factory Modelo.fromMap(Map<String, dynamic> map) => Modelo(
    id_modelo: map['id_modelo'],
    id_cliente: map['id_cliente'],
    modelo: map['modelo'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id_modelo": id_modelo,
    "id_cliente": id_cliente,
    "modelo": modelo
  };
}