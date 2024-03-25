class Panel{
  int? id;
  String? descripcion;
  String? marca;
  String? notas;

  Panel({
    this.id,
    this.descripcion,
    this.marca,
    this.notas,
  });

  // @override
  // String toString() {
  //   return 'Panel { descripcion: $descripcion, marca: $marca, notas: $notas }';
  // }

  factory Panel.fromMap(Map<String, dynamic> map) => Panel(
    id: map['id'],
    descripcion: map['descripcion'].toString(),
    marca: map['marca'].toString(),
    notas: map['notas'].toString(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "descripcion": descripcion,
    "marca": marca,
    "notas": notas
  };
}