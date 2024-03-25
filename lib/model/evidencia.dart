class Evidencia{
  int? id;
  String? vin;
  String? dano;
  String? nombre;
  String? notas;
  String? fechahora;
  String? archivo;

  Evidencia({
    this.id,
    this.vin,
    this.dano,
    this.nombre,
    this.notas,
    this.fechahora,
    this.archivo
  });

  // @override
  // String toString() {
  //   return 'Evidencia { vin: $vin, dano: $dano, nombre: $nombre, notas: $notas, fechahora: $fechahora, archivo: $archivo }';
  // }

  factory Evidencia.fromMap(Map<String, dynamic> map) => Evidencia(
    id: map['id'],
    vin: map['vin'].toString(),
    dano: map['dano'].toString(),
    nombre: map['nombre'].toString(),
    notas: map['notas'].toString(),
    fechahora: map['fechahora'].toString(),
    archivo: map['archivo'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "vin": vin,
    "dano": dano,
    "nombre": nombre,
    "notas": notas,
    "fechahora": fechahora,
    "archivo": notas
  };
}