class Dano{
  int? id;
  String? vin;
  String? panel;
  int? area;
  int? tipo;
  int? severidad;
  String? fecha_creacion;

  Dano({
    this.id,
    this.vin,
    this.panel,
    this.area,
    this.tipo,
    this.severidad,
    this.fecha_creacion
  });

  // @override
  // String toString() {
  //   return 'Dano { vin: $vin, panel: $panel, nombre: $nombre, fecha_creacion: $fecha_creacion }';
  // }

  factory Dano.fromMap(Map<String, dynamic> map) => Dano(
    id: map['id'],
    vin: map['vin'].toString(),
    panel: map['panel'].toString(),
    area: map['area'],
    tipo: map['tipo'],
    severidad: map['severidad'],
    fecha_creacion: map['fecha_creacion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "vin": vin,
    "panel": panel,
    "area": area,
    "tipo": tipo,
    "severidad": severidad,
    "fecha_creacion": fecha_creacion
  };
}