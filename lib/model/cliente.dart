class Cliente{
  int? idAdvan;
  String? cliente;

  Cliente({
    this.idAdvan,
    this.cliente
  });

  @override
  String toString() {
    return 'Cliente { cliente: $cliente, idAdvan: $idAdvan }';
  }

  factory Cliente.fromMap(Map<String, dynamic> map) => Cliente(
    idAdvan: map['idAdvan'],
    cliente: map['cliente'].toString()
  );

  Map<String, dynamic> toMap() => {
    "idAdvan": idAdvan,
    "cliente": cliente
  };
}