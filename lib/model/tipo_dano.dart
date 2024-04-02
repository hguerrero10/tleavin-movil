class TipoDano{
  int? id;
  String? descripcion;

  TipoDano({
    this.id,
    this.descripcion
  });

  @override
  String toString() {
    return 'TipoDano { descripcion: $descripcion, id: $id }';
  }

  factory TipoDano.fromMap(Map<String, dynamic> map) => TipoDano(
    id: map['id'],
    descripcion: map['descripcion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "descripcion": descripcion
  };
}