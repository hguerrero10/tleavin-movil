class Dano{
  int? id;
  String? vin;
  String? panel;
  String? nombre;
  String? fecha_creacion;

  Dano({
    this.id,
    this.vin,
    this.panel,
    this.nombre,
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
    nombre: map['nombre'].toString(),
    fecha_creacion: map['fecha_creacion'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "vin": vin,
    "panel": panel,
    "nombre": nombre,
    "fecha_creacion": fecha_creacion
  };
}