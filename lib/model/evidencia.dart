class Evidencia{
  int? id;
  String? vin;
  String? dano;
  String? nombre;
  String? archivo;
  String? fechahora;

  Evidencia({
    this.id,
    this.vin,
    this.dano,
    this.nombre,
    this.archivo,
    this.fechahora
  });

  @override
  String toString() {
    return 'Evidencia { vin: $vin, dano: $dano, nombre: $nombre, archivo: $archivo, fechahora: $fechahora, id: $id }';
  }

  factory Evidencia.fromMap(Map<String, dynamic> map) => Evidencia(
    id: map['id'],
    vin: map['vin'].toString(),
    dano: map['dano'].toString(),
    nombre: map['nombre'].toString(),
    archivo: map['archivo'].toString(),
    fechahora: map['fechahora'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "vin": vin,
    "dano": dano,
    "nombre": nombre,
    "archivo": archivo,
    "fechahora": fechahora
  };
}