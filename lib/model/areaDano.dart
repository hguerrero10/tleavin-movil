class AreaDano{
  int? id;
  String? area;
  String? descripcion;

  AreaDano({
    this.id,
    this.area,
    this.descripcion
  });

  @override
  String toString() {
    return 'AreaDano { area: $area, descripcion: $descripcion, id: $id }';
  }

  factory AreaDano.fromMap(Map<String, dynamic> map) => AreaDano(
    id: map['id'],
    area: map['area'].toString(),
    descripcion: map['descripcion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "area": area,
    "descripcion": descripcion
  };

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['area'] = area;
    data['descripcion'] = descripcion;

    return data;
  }
}