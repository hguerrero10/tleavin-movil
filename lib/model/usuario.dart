class Usuario {
  int? numeroEmpleado;
  String? nombre;
  String? usuario;
  String? password;
  int? isLogged;
  String? cargo;
  String? locacion;
  String? estado;

  Usuario({
    this.numeroEmpleado,
    this.nombre,
    this.usuario,
    this.password,
    this.isLogged,
    this.cargo,
    this.locacion,
    this.estado
  });

  @override
  String toString() {
    return 'Usuario { nombre: $nombre, usuario: $usuario, password: $password, isLogged: $isLogged, cargo: $cargo, locacion: $locacion, estado: $estado, numero_empleado: $numeroEmpleado }';
  }

  factory Usuario.fromMap(Map<String, dynamic> map) => Usuario(
    numeroEmpleado: map['numero_empleado'],
    nombre: map['nombre'].toString(),
    usuario: map['usuario'].toString(),
    password: map['password'].toString(),
    isLogged: map['isLogged'],
    cargo: map['cargo'].toString(),
    locacion: map['locacion'].toString(),
    estado: map['estado'].toString()
  );

  Map<String, dynamic> toMap() => {
    "numero_empleado": numeroEmpleado,
    "nombre": nombre,
    "usuario": usuario,
    "password": password,
    "isLogged": isLogged,
    "cargo": cargo,
    "locacion": locacion,
    "estado": estado
  };
}