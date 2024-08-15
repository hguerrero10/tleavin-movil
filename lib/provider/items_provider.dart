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
  String? firmaOperadorLogistico;
  String? firmaOperador;

  String? clienteSeleccionado;
  String? destinoSeleccionado;
  String? orientacionSeleccionado;

  Usuario? usuario;
  String? ubicacion;

  bool danoAreaInsert = false;
  bool danoAreaInsertTimeOut = false;
  bool registroAreaDano = false;

  bool tipoAreaInsert = false;
  bool tipoAreaInsertTimeOut = false;
  bool registroTipoDano = false;

  bool severidadInsert = false;
  bool severidadInsertTimeOut = false;
  bool registroSeveridad = false;

  bool clienteInsert = false;
  bool clienteInsertTimeOut = false;
  bool registroCliente = false;

  var vinesSeleccionadosParaViaje = [];

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
    itemP.firmaOperadorLogistico = item;
    itemP.itemStreamController.sink.add(firmaOperadorLogistico);
  }

  void deleteFirmaOperadorLogisticio() {
    itemP.firmaOperadorLogistico = null;
    itemP.itemStreamController.sink.add(firmaOperadorLogistico);
  }

  void addFirmaOperador(item) {
    itemP.firmaOperador = item;
    itemP.itemStreamController.sink.add(firmaOperador);
  }

  void deleteFirmaOperador() {
    itemP.firmaOperador = null;
    itemP.itemStreamController.sink.add(firmaOperador);
  }




























  void addDanoAreaInsert() {
    itemP.danoAreaInsert = true;
    itemP.itemStreamController.sink.add(danoAreaInsert);
  }

  void deleteAreaDanonsert() {
    itemP.danoAreaInsert = false;
    itemP.itemStreamController.sink.add(danoAreaInsert);
  }

  void addAreaDanoInsertTimeOut() {
    itemP.danoAreaInsertTimeOut = true;
    itemP.itemStreamController.sink.add(danoAreaInsertTimeOut);
  }

  void deleteAreaDanoInsertTimeOut() {
    itemP.danoAreaInsertTimeOut = false;
    itemP.itemStreamController.sink.add(danoAreaInsertTimeOut);
  }

  void addRegistroAreaDano() {
    itemP.registroAreaDano = true;
    itemP.itemStreamController.sink.add(registroAreaDano);
  }

  void deleteRegistroAreaDano() {
    itemP.registroAreaDano = false;
    itemP.itemStreamController.sink.add(registroAreaDano);
  }






  void addTipoDanoInsert() {
    itemP.tipoAreaInsert = true;
    itemP.itemStreamController.sink.add(tipoAreaInsert);
  }

  void deleteTipoDanoinsert() {
    itemP.tipoAreaInsert = false;
    itemP.itemStreamController.sink.add(tipoAreaInsert);
  }

  void addTipoDanoInsertTimeOut() {
    itemP.tipoAreaInsertTimeOut = true;
    itemP.itemStreamController.sink.add(tipoAreaInsertTimeOut);
  }

  void deleteTipoDanoInsertTimeOut() {
    itemP.tipoAreaInsertTimeOut = false;
    itemP.itemStreamController.sink.add(tipoAreaInsertTimeOut);
  }

  void addRegistroTipoDano() {
    itemP.registroTipoDano = true;
    itemP.itemStreamController.sink.add(registroTipoDano);
  }

  void deleteRegistroTipoDano() {
    itemP.registroTipoDano = false;
    itemP.itemStreamController.sink.add(registroTipoDano);
  }








  void addSeveridadInsert() {
    itemP.severidadInsert = true;
    itemP.itemStreamController.sink.add(severidadInsert);
  }

  void deleteSeveridadInsert() {
    itemP.severidadInsert = false;
    itemP.itemStreamController.sink.add(severidadInsert);
  }

  void addSeveridadInsertTimeOut() {
    itemP.severidadInsertTimeOut = true;
    itemP.itemStreamController.sink.add(severidadInsertTimeOut);
  }

  void deleteSeveridadInsertTimeOut() {
    itemP.severidadInsertTimeOut = false;
    itemP.itemStreamController.sink.add(severidadInsertTimeOut);
  }

  void addRegistroSeveridad() {
    itemP.registroSeveridad = true;
    itemP.itemStreamController.sink.add(registroSeveridad);
  }

  void deleteRegistroSeveridad() {
    itemP.registroSeveridad = false;
    itemP.itemStreamController.sink.add(registroSeveridad);
  }





  void addClienteInsert() {
    itemP.clienteInsert = true;
    itemP.itemStreamController.sink.add(clienteInsert);
  }

  void deleteClienteInsert() {
    itemP.clienteInsert = false;
    itemP.itemStreamController.sink.add(clienteInsert);
  }

  void addClienteInsertTimeOut() {
    itemP.clienteInsertTimeOut = true;
    itemP.itemStreamController.sink.add(clienteInsertTimeOut);
  }

  void deleteClienteInsertTimeOut() {
    itemP.clienteInsertTimeOut = false;
    itemP.itemStreamController.sink.add(clienteInsertTimeOut);
  }

  void addRegistroCliente() {
    itemP.registroCliente = true;
    itemP.itemStreamController.sink.add(registroCliente);
  }

  void deleteRegistroCliente() {
    itemP.registroCliente = false;
    itemP.itemStreamController.sink.add(registroCliente);
  }









































  void addVSPV(values) {
    itemP.vinesSeleccionadosParaViaje = [];
    itemP.vinesSeleccionadosParaViaje = values;
    itemP.itemStreamController.sink.add(vinesSeleccionadosParaViaje);
  }

  void deleteVSPV() {
    itemP.vinesSeleccionadosParaViaje = [];
    itemP.itemStreamController.sink.add(vinesSeleccionadosParaViaje);
  }


  void addClienteSeleccionado(item) {
    itemP.clienteSeleccionado = item;
    itemP.itemStreamController.sink.add(clienteSeleccionado);
  }

  void deleteClienteSeleccionado() {
    itemP.clienteSeleccionado = null;
    itemP.itemStreamController.sink.add(clienteSeleccionado);
  }


  void addDestinoSeleccionado(item) {
    itemP.destinoSeleccionado = item;
    itemP.itemStreamController.sink.add(destinoSeleccionado);
  }

  void deleteDestinoSeleccionado() {
    itemP.destinoSeleccionado = null;
    itemP.itemStreamController.sink.add(destinoSeleccionado);
  }

  void addOrientacionSeleccionado(item) {
    itemP.orientacionSeleccionado = item;
    itemP.itemStreamController.sink.add(orientacionSeleccionado);
  }

  void deleteOrientacionSeleccionado() {
    itemP.orientacionSeleccionado = null;
    itemP.itemStreamController.sink.add(orientacionSeleccionado);
  }

}

final itemP = ItemsProvider();