class Severidad{
  int? id;
  String? tipo;
  String? descripcion;

  Severidad({
    this.id,
    this.tipo,
    this.descripcion
  });

  @override
  String toString() {
    return 'Severidad { tipo: $tipo, descripcion: $descripcion, id: $id }';
  }

  factory Severidad.fromMap(Map<String, dynamic> map) => Severidad(
    id: map['id'],
    tipo: map['tipo'].toString(),
    descripcion: map['descripcion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tipo": tipo,
    "descripcion": descripcion
  };
}