import 'dart:async';
import 'package:tleavin_mobil/model/usuario.dart';

class ItemsProvider {

  final itemStreamController = StreamController.broadcast();

  Stream get getStream => itemStreamController.stream;

  final Map items = {'item': []};

  bool boton = false;
  bool error = false;
  bool loginInsert = false;
  bool loginInsertTimeOut = false;
  bool registroUser = false;

  String? firmainspector;
  String? firmainspectorlogistico;

  Usuario? usuario;
  String? ubicacion;

  void addUser(Usuario item) {
    if(item.toString().isNotEmpty) {
      itemP.usuario = Usuario(
        numeroEmpleado: item.numeroEmpleado,
        nombre: item.nombre,
        usuario: item.usuario,
        password: item.password,
        isLogged: item.isLogged,
        cargo: item.cargo,
        locacion: item.locacion,
        estado: item.estado
      );
    }
    
    itemP.itemStreamController.sink.add(itemP.usuario);
  }

  addUbi(item) {
    itemP.ubicacion = item;
    itemStreamController.sink.add(itemP.ubicacion);
  }

  void addBoton() {
    itemP.boton = true;
    itemP.itemStreamController.sink.add(boton);
  }

  void deleteBoton() {
    itemP.boton = false;
    itemP.itemStreamController.sink.add(boton);
  }

  void addError() {
    itemP.error = true;
    itemP.itemStreamController.sink.add(error);
  }

  void deleteError() {
    itemP.error = false;
    itemP.itemStreamController.sink.add(error);
  }

    void addLoginInsert() {
    itemP.loginInsert = true;
    itemP.itemStreamController.sink.add(loginInsert);
  }

  void deleteLoginInsert() {
    itemP.loginInsert = false;
    itemP.itemStreamController.sink.add(loginInsert);
  }

  void addLoginInsertTimeOut() {
    itemP.loginInsertTimeOut = true;
    itemP.itemStreamController.sink.add(loginInsertTimeOut);
  }

  void deleteLoginInsertTimeOut() {
    itemP.loginInsertTimeOut = false;
    itemP.itemStreamController.sink.add(loginInsertTimeOut);
  }

  void addRegistroUser() {
    itemP.registroUser = true;
    itemP.itemStreamController.sink.add(registroUser);
  }

  void deleteRegistroUser() {
    itemP.registroUser = false;
    itemP.itemStreamController.sink.add(registroUser);
  }

  void addFirmaInspecctor(item) {
    itemP.firmainspector = item;
    itemP.itemStreamController.sink.add(firmainspector);
  }

  void deleteFirmaInspecctor() {
    itemP.firmainspector = null;
    itemP.itemStreamController.sink.add(firmainspector);
  }

  void addFirmaOperadorLogisticio(item) {
    itemP.firmainspectorlogistico = item;
    itemP.itemStreamController.sink.add(firmainspectorlogistico);
  }

  void deleteFirmaOperadorLogisticio() {
    itemP.firmainspectorlogistico = null;
    itemP.itemStreamController.sink.add(firmainspectorlogistico);
  }

}

final itemP = ItemsProvider();