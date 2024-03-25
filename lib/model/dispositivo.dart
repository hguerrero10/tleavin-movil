class Dispositivo{
  int? id;
  String? descripcion;
  String? api_key;
  String? usuario;
  String? notas;

  Dispositivo({
    this.id,
    this.descripcion,
    this.api_key,
    this.usuario,
    this.notas
  });

  // @override
  // String toString() {
  //   return 'Dispositivo { descripcion: $descripcion, api_key: $api_key, usuario: $usuario, notas: $notas }';
  // }

  factory Dispositivo.fromMap(Map<String, dynamic> map) => Dispositivo(
    id: map['id'],
    descripcion: map['descripcion'].toString(),
    api_key: map['api_key'].toString(),
    usuario: map['usuario'].toString(),
    notas: map['notas'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "descripcion": descripcion,
    "api_key": api_key,
    "usuario": usuario,
    "notas": notas
  };
}