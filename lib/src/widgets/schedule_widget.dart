import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/widgets/radio_widget.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  final TurnosBloc _turnosBloc;
  final xml;
  Schedule(this._turnosBloc,this.xml);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: triggerRequest(widget.xml,'getReservaHorasDisponibles'),
      builder: (context,snapshot) {
        return snapshot.connectionState == ConnectionState.done ? _createRadioButtons(snapshot) : CircularProgressIndicator();
      }
    );
  }

  Widget _createRadioButtons(AsyncSnapshot snapshot) {
    List<Widget> lstRadioBtn = [];
    if(snapshot.data[0] != ''){
      for (String item in snapshot.data) {
        var label = item.replaceAll('"', '').substring(6,11);
        final Widget radioBtn = 
        StreamBuilder(
          stream: widget._turnosBloc.selectedHourStream,
          builder: (context,snapshot){
            return RadioButton(label, widget._turnosBloc, snapshot);
          });
        lstRadioBtn.add(radioBtn);
      }
    }
    return Wrap(
      direction: Axis.horizontal,
      children: lstRadioBtn.isEmpty ? [Text('No hay turnos disponibles')] : lstRadioBtn
    );
  }
}