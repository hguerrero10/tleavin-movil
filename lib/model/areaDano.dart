class AreaDano{
  int? id;
  int? codigo;
  String? area;
  String? descripcion;

  AreaDano({
    this.id,
    this.codigo,
    this.area,
    this.descripcion
  });

  @override
  String toString() {
    return 'AreaDano { codigo: $codigo, area: $area, descripcion: $descripcion, id: $id }';
  }

  factory AreaDano.fromMap(Map<String, dynamic> map) => AreaDano(
    id: map['id'],
    codigo: map['codigo'],
    area: map['area'].toString(),
    descripcion: map['descripcion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "codigo": codigo,
    "area": area,
    "descripcion": descripcion
  };

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['codigo'] = codigo;
    data['area'] = area;
    data['descripcion'] = descripcion;

    return data;
  }
}