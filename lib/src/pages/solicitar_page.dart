import 'dart:convert';
import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/models/servicios_data.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/util/routes.dart';
import 'package:app_pelu/src/widgets/appBar_widget.dart';
import 'package:app_pelu/src/widgets/schedule_widget.dart';
import 'package:app_pelu/src/widgets/servicio_widget.dart';
import 'package:app_pelu/src/widgets/turnoContainer_widget.dart';
import 'package:app_pelu/src/widgets/turnosListContainer_widget.dart';
import 'package:flutter/material.dart';

class Solicitar extends StatefulWidget {
  final UserData userData;
  Solicitar(this.userData);

  @override
  _SolicitarState createState() => _SolicitarState();
}

class _SolicitarState extends State<Solicitar> {
  TurnosBloc _turnosBloc = TurnosBloc(); 

  @override
  void initState() {
    var xml = TurnosProvider().getReservaDiasDisponibles(widget.userData.id);
    Future<List<String>> servicios = triggerRequest(getReservaServiciosDisponiblesXml,'getReservaServiciosDisponibles');
    Future<List<String>> diasTurnos = triggerRequest(xml,'getReservaDiasDisponibles');

    super.initState();
    diasTurnos.then((List<String> diasRsp) async {
      List<String> turnos = [];
        if(diasRsp[0] != ''){
          for (var item in diasRsp ){
            var json = jsonDecode(item);
            var fecha = json['Fecha'];
            turnos.add(fecha);
          }
        _turnosBloc.datesSink(turnos);
      }else{
        _turnosBloc.datesSink(turnos);
      }
    });
    servicios.then((List<String> serviciosRsp) => _handleServiciosResponse(serviciosRsp));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Solicitar Turno'),
      body: Container(
        child: StreamBuilder(
          stream: _turnosBloc.datesStream,
          builder: (context,snapshot) => snapshot.hasData ? _createTurnos(snapshot) : Center(child: CircularProgressIndicator()))),
    );
  }

  _createTurnos(AsyncSnapshot<List<String>> snapshot) {
    if(snapshot.data.length == 0){
      return Center(child: Text('No se encontraron turnos disponibles'));
    }
    List<Widget> lstContainer = [];
    _turnosBloc.selectedHourSink('');
    _turnosBloc.selectedDateSink(_turnosBloc.dates.first);

    for (var date in snapshot.data) {
      lstContainer.add(TurnoContainer(date,_turnosBloc));
    }
    
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top:10),
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(left: 10),child: Align(alignment: Alignment.centerLeft,child: Text('Día',style: TextStyle(fontSize: 20)))),
              SizedBox(height: 10),
              ListContainerTurnos(lstContainer),
              Divider(color: Colors.grey[400],endIndent: 15,indent: 15),
            ],
          ),
        ),
        snapshot.hasData ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(alignment: Alignment.centerLeft,child: Text('Hora',style: TextStyle(fontSize: 20))),
                ],
            )),
            StreamBuilder<String>(
              stream: _turnosBloc.selectedDateStream,
              builder: (context, snapshot) {
                var xml = snapshot.hasData ? TurnosProvider().getReservaHorasDisponibles(snapshot.data) : '';
                return snapshot.hasData ? Schedule(_turnosBloc, xml) : CircularProgressIndicator();
              }
            ),
            //Container()
          ],
        ) : Container(),

        Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: [
              Divider(color: Colors.grey[400],endIndent: 15,indent: 15),
              Container(margin: EdgeInsets.only(left: 10), child: Align(alignment: Alignment.centerLeft,child: Text('Servicio',style: TextStyle(fontSize: 20)))),
              SizedBox(height: 20),
              StreamBuilder<List<Servicios>>(
                stream: _turnosBloc.misServiciosStream,
                builder: (context, snapshot) {
                  return snapshot.hasData ? ContainerServicios(_turnosBloc) : Center(child: CircularProgressIndicator());
                }
              ),
            ],
          ),
        ),
        StreamBuilder<String>(
          stream: _turnosBloc.selectedHourStream,
          builder: (context, snapshot) {
            return ElevatedButton.icon(
              label: Text('Reservar',style:TextStyle(fontWeight:FontWeight.bold)),
              icon: Icon(Icons.calendar_today_outlined),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                fixedSize: Size(MediaQuery.of(context).size.width / 1.5, MediaQuery.of(context).size.height / 18),
                primary: Color(0xFF4BA661),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
              ),
              onPressed:  snapshot.data != '' ? (){
                var xml = TurnosProvider().turnoAsignar(_turnosBloc.selectedDate, _turnosBloc.selectedHour, widget.userData.id, _turnosBloc.selectedService.id);
                Future asignarTurno = triggerRequest(xml, 'turnosAsignar');
                return showModalBottomSheet(
                  isDismissible: true,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
                  context: context, 
                  builder: (context){
                    return FutureBuilder(
                      future: asignarTurno,
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }else{
                          var json = jsonDecode(snapshot.data[0]);
                          var codRsp = json['codigo'];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              codRsp == '0' ? Icon(Icons.check_circle_outline,color: Colors.green,size: 30) : Icon(Icons.clear,color: Colors.red,size: 30),
                              Text(codRsp == '0' ? 'Turno confirmado!' : 'Error al confirmar turno'),
                              ElevatedButton(onPressed: () => setRoute('Turnos',widget.userData,context,true,null), child: Text('Ver mis turnos'))
                            ],
                          ); 
                        }
                      }
                      );
                });
              } : null, 
              );
          }
        ),
      ],
    );
  }

  _handleServiciosResponse(List<String> serviciosRsp) {
    List<Servicios> lstServicios = [];
    for (var item in serviciosRsp) {
      var json = jsonDecode(item);
      Servicios servicio = Servicios(int.parse(json['Id']),json['Nombre']);
      lstServicios.add(servicio);
    }
    _turnosBloc.selectedServiceSink(lstServicios[0]);
    _turnosBloc.misServiciosSink(lstServicios);
  }
}