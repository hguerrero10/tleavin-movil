class Evidencia{
  int? ide;
  String? vin;
  int? iddano;
  int? idviaje;
  String? nombre;
  String? archivo;
  String? fechahora;

  Evidencia({
    this.ide,
    this.vin,
    this.iddano,
    this.idviaje,
    this.nombre,
    this.archivo,
    this.fechahora
  });

  @override
  String toString() {
    return '{"ide": $ide, "vin": "$vin", "iddano": $iddano, "idviaje": $idviaje, "nombre": "$nombre", "fechahora": "$fechahora", "archivo": "$archivo"}';
  }

  factory Evidencia.fromMap(Map<String, dynamic> map) => Evidencia(
    ide: map['ide'],
    vin: map['vin'].toString(),
    iddano: map['iddano'],
    idviaje: map['idviaje'],
    nombre: map['nombre'].toString(),
    archivo: map['archivo'].toString(),
    fechahora: map['fechahora'].toString()
  );

  Map<String, dynamic> toMap() => {
    "ide": ide,
    "vin": vin,
    "iddano": iddano,
    "idviaje": idviaje,
    "nombre": nombre,
    "archivo": archivo,
    "fechahora": fechahora
  };
}