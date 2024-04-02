class Cliente{
  int? id;
  int? idAdvan;
  String? cliente;

  Cliente({
    this.id,
    this.idAdvan,
    this.cliente
  });

  @override
  String toString() {
    return 'Cliente { idAdvan: $idAdvan, cliente: $cliente, id: $id }';
  }

  factory Cliente.fromMap(Map<String, dynamic> map) => Cliente(
    id: map['id'],
    idAdvan: map['idAdvan'],
    cliente: map['cliente'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idAdvan": idAdvan,
    "cliente": cliente
  };
}