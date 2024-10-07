import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/vin.dart';

class Tarja{
  int? id_tarja;
  String? destino;
  int? vines;
  String? registro;
  String? registrado_por;
  List<Vin>? vinesList;
  List<Evidencia>? fotos;

  Tarja({
    this.id_tarja,
    this.destino,
    this.vines,
    this.registro,
    this.registrado_por,
    this.vinesList = const [],
    this.fotos = const []
  });

  @override
  String toString() {
    return '{ "id_tarja": $id_tarja, "destino": "$destino", "vines": $vines, "registro": "$registro", "registrado_por": "$registrado_por", "vinesList": $vinesList, "fotos": $fotos }';
  }

  factory Tarja.fromMap(Map<String, dynamic> map) => Tarja(
    id_tarja: map['id_tarja'],
    destino: map['destino'].toString(),
    vines: map['vines'],
    registro: map['registro'].toString(),
    registrado_por: map['registrado_por'].toString(),
    vinesList: map['vinesList'],
    fotos: map['fotos']
  );

  Map<String, dynamic> toMap() => {
    "id_tarja": id_tarja,
    "destino": destino,
    "vines": vines,
    "registro": registro,
    "registrado_por": registrado_por
  };
}