class Usuario {
  int? numero_empleado;
  String? nombre;
  String? usuario;
  String? password;
  int? isLogged;
  String? cargo;
  String? estado;

  Usuario({
    this.numero_empleado,
    this.nombre,
    this.usuario,
    this.password,
    this.isLogged,
    this.cargo,
    this.estado
  });

  @override
  String toString() {
    return 'Usuario { nombre: $nombre, usuario: $usuario, password: $password, isLogged: $isLogged, cargo: $cargo, estado: $estado, numero_empleado: $numero_empleado }';
  }

  factory Usuario.fromMap(Map<String, dynamic> map) => Usuario(
    numero_empleado: map['numero_empleado'],
    nombre: map['nombre'].toString(),
    usuario: map['usuario'].toString(),
    password: map['password'].toString(),
    isLogged: map['isLogged'],
    cargo: map['cargo'].toString(),
    estado: map['estado'].toString()
  );

  Map<String, dynamic> toMap() => {
    "numero_empleado": numero_empleado,
    "nombre": nombre,
    "usuario": usuario,
    "password": password,
    "isLogged": isLogged,
    "cargo": cargo,
    "estado": estado
  };
}