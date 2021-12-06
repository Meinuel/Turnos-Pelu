import 'dart:convert';
import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/models/turnosCliente_data.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/appBar_widget.dart';
import 'package:app_pelu/src/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class MisTurnos extends StatefulWidget {
  final UserData userData;
  MisTurnos(this.userData);

  @override
  _MisTurnosState createState() => _MisTurnosState();
}

class _MisTurnosState extends State<MisTurnos> {
  final TurnosBloc _turnosBloc = new TurnosBloc();
  @override
  void initState() {
    final xml = TurnosProvider().getTurnoPedidoPorCliente(widget.userData.id);
    Future<List<String>> misTurnos = triggerRequest(xml, 'getTurnoPedidoPorCliente'); 
    super.initState();
    misTurnos.then((value) => _handleResponse(value));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamed(context, 'Principal',arguments: widget.userData);
        Future<bool> dazos = Future.delayed(Duration(milliseconds: 200),
          (){
            return true;
          });
          return dazos;
      },
      child: Scaffold(
        appBar: appBar('Mis turnos'),
        body: StreamBuilder<Object>(
          stream: _turnosBloc.misTurnosStream,
          builder: (_, snapshot) => snapshot.hasData ? _createCards(snapshot) : Center(child: CircularProgressIndicator())
        ),
      ),
    );
  }
  _createCards(AsyncSnapshot snapshot){
    final List<TurnosCliente> misTurnos = snapshot.data ?? [];
    return misTurnos.length != 0 ? ListView.builder(
      itemCount: misTurnos.length,
      itemBuilder: (_,i) {
        final TurnosCliente turno = TurnosCliente(misTurnos[i].id,misTurnos[i].fecha,misTurnos[i].hora,misTurnos[i].servicioId,misTurnos[i].servicioNombre); 
        return MyCard(turno,widget.userData);
      }) : Center(child: Text('Todavía no tenés turnos reservados'));
  }
  _handleResponse(List<String> value){
    List<TurnosCliente> lstMisTurnos = [];
    if( value[0] != ''){
      for (var item in value) {
        final List<String> lstItem = item.split(',');
        var hora = lstItem[2].substring(7,lstItem[2].length).replaceAll('"', '');
        item = lstItem[0] + ',' + lstItem[1] + ',' + lstItem[3] + ',' + lstItem[4];
        var json = jsonDecode(item);
        lstMisTurnos.add(TurnosCliente(int.parse(json['Id']),json['Fecha'],hora,int.parse(json['ServicioId']),json['Nombre']));
      }
      _turnosBloc.misTurnosSink(lstMisTurnos);
    }else{
      _turnosBloc.misTurnosSink(lstMisTurnos);
    }
  }
}