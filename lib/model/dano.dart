class Dano{
  int? id;
  String? vin;
  String? panel;
  int? area;
  int? tipo;
  int? severidad;
  String? nota;
  String? fecha_creacion;

  Dano({
    this.id,
    this.vin,
    this.panel,
    this.area,
    this.tipo,
    this.severidad,
    this.nota,
    this.fecha_creacion
  });

  @override
  String toString() {
    return 'Dano { vin: $vin, panel: $panel, area: $area, tipo: $tipo, severidad: $severidad, nota: $nota, fecha_creacion: $fecha_creacion, id: $id }';
  }

  factory Dano.fromMap(Map<String, dynamic> map) => Dano(
    id: map['id'],
    vin: map['vin'].toString(),
    panel: map['panel'].toString(),
    area: map['area'],
    tipo: map['tipo'],
    severidad: map['severidad'],
    nota: map['nota'].toString(),
    fecha_creacion: map['fecha_creacion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "vin": vin,
    "panel": panel,
    "area": area,
    "tipo": tipo,
    "severidad": severidad,
    "nota": nota,
    "fecha_creacion": fecha_creacion
  };
}