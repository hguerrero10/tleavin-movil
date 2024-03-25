class Supervisor{
  int? id;
  String? nombre;
  String? email;
  String? ubicacion;
  String? notas;

  Supervisor({
    this.id,
    this.nombre,
    this.email,
    this.ubicacion,
    this.notas
  });

  // @override
  // String toString() {
  //   return 'Supervisor { nombre: $nombre, email: $email, ubicacion: $ubicacion, notas: $notas }';
  // }

  factory Supervisor.fromMap(Map<String, dynamic> map) => Supervisor(
    id: map['id'],
    nombre: map['nombre'].toString(),
    email: map['email'].toString(),
    ubicacion: map['ubicacion'].toString(),
    notas: map['notas'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "email": email,
    "ubicacion": ubicacion,
    "notas": notas
  };
}