import 'package:tleavin_mobil/model/evidencia.dart';

class Dano{
  int? idd;
  String? vin;
  String? panel;
  String? registroTipo;
  int? area;
  int? tipo;
  int? severidad;
  String? nota;
  String? fecha_creacion;
  List<Evidencia>? evidencias;

  Dano({
    this.idd,
    this.vin,
    this.panel,
    this.registroTipo,
    this.area,
    this.tipo,
    this.severidad,
    this.nota,
    this.fecha_creacion,
    this.evidencias = const [],
  });

  @override
  String toString() {
    return '{"idd": $idd, "vin": "$vin", "panel": "$panel", "registroTipo": "$registroTipo", "area": $area, "tipo": $tipo, "severidad": $severidad, "nota": "$nota", "fecha_creacion": "$fecha_creacion", "evidencias": $evidencias}';
  }

  factory Dano.fromMap(Map<String, dynamic> map) => Dano(
    idd: map['idd'],
    vin: map['vin'].toString(),
    panel: map['panel'].toString(),
    registroTipo: map['registroTipo'].toString(),
    area: map['area'],
    tipo: map['tipo'],
    severidad: map['severidad'],
    nota: map['nota'].toString(),
    fecha_creacion: map['fecha_creacion'].toString(),
    evidencias: map['evidencias']
  );

  Map<String, dynamic> toMap() => {
    "idd": idd,
    "vin": vin,
    "panel": panel,
    "registroTipo": registroTipo,
    "area": area,
    "tipo": tipo,
    "severidad": severidad,
    "nota": nota,
    "fecha_creacion": fecha_creacion
  };
}