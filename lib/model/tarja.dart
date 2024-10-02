class Tarja{
  int? id_tarja;
  String? destino;
  int? vines;
  String? registro;
  String? registrado_por;

  Tarja({
    this.id_tarja,
    this.destino,
    this.vines,
    this.registro,
    this.registrado_por
  });

  @override
  String toString() {
    return 'Tarja { destino: $destino, vines: $vines, registro: $registro, registrado_por: $registrado_por, id_tarja: $id_tarja }';
  }

  factory Tarja.fromMap(Map<String, dynamic> map) => Tarja(
    id_tarja: map['id_tarja'],
    destino: map['destino'].toString(),
    vines: map['vines'],
    registro: map['registro'].toString(),
    registrado_por: map['registrado_por'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id_tarja": id_tarja,
    "destino": destino,
    "vines": vines,
    "registro": registro,
    "registrado_por": registrado_por
  };
}