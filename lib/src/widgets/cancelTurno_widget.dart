import 'dart:convert';

import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:app_pelu/src/util/models/turnosCliente_data.dart';
import 'package:app_pelu/src/util/parse_month.dart';
import 'package:flutter/material.dart';

class CancelTurno extends StatefulWidget {
  final TurnosCliente turno;
  CancelTurno(this.turno);
  @override
  _CancelTurnoState createState() => _CancelTurnoState();
}

class _CancelTurnoState extends State<CancelTurno> {
  bool isCancel = false ;
  Future cancel;
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: cancel,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.none){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Está por cancelar el turno : ${widget.turno.fecha} a las ${widget.turno.hora.substring(0,5)} ${getDayTime(widget.turno.hora.substring(0,2))}'),
              Text('¿Seguro que desea continar?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        final xml = TurnosProvider().turnoCancelar(widget.turno.id,widget.turno.fecha,widget.turno.hora,'');
                        cancel = triggerRequest(xml, 'turnoCancelar');
                      });
                    },
                    child: Text('Si')),
                  ElevatedButton(onPressed: () => Navigator.pop(context,false), child: Text('No')),
                ],
              )
            ],
          );
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
          return _createRsp(snapshot);
        }
      }
    );
  }

  _createRsp(AsyncSnapshot snapshot) {
    var json = jsonDecode(snapshot.data[0]);
    var codRsp = json['codigo'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(codRsp == '0' ? Icons.check_circle_outline : Icons.clear),
        Text(codRsp == '0' ? 'Turno cancelado exitosamente' : 'Error en la solicitud, intente nuevamente'),
        ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Volver'))
      ],
    );
  }
}