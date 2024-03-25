class Periodo{
  int? id;
  String? app;
  String? tipo;
  String? anio;
  String? semana;
  String? mes;
  String? sem_mes;
  String? descripcion;
  String? fecha_ini;
  String? fecha_fin;
  String? notas;

  Periodo({
    this.id,
    this.app,
    this.tipo,
    this.anio,
    this.semana,
    this.mes,
    this.sem_mes,
    this.descripcion,
    this.fecha_ini,
    this.fecha_fin,
    this.notas,
  });

  // @override
  // String toString() {
  //   return 'Periodo { app: $app, tipo: $tipo, anio: $anio, semana: $semana, mes: $mes, sem_mes: $sem_mes, descripcion: $descripcion, fecha_ini: $fecha_ini, fecha_fin: $fecha_fin, notas: $notas }';
  // }

  factory Periodo.fromMap(Map<String, dynamic> map) => Periodo(
    id: map['id'],
    app: map['app'].toString(),
    tipo: map['tipo'].toString(),
    anio: map['anio'].toString(),
    semana: map['semana'].toString(),
    mes: map['mes'].toString(),
    sem_mes: map['sem_mes'].toString(),
    descripcion: map['descripcion'].toString(),
    fecha_ini: map['fecha_ini'].toString(),
    fecha_fin: map['fecha_fin'].toString(),
    notas: map['notas'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "app": app,
    "tipo": tipo,
    "anio": anio,
    "semana": semana,
    "mes": mes,
    "sem_mes": sem_mes,
    "descripcion": descripcion,
    "fecha_ini": fecha_ini,
    "fecha_fin": fecha_fin,
    "notas": notas
  };
}