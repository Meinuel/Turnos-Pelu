import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/widgets/radio_widget.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  final TurnosBloc _turnosBloc;
  Schedule(this._turnosBloc);

  @override
  
  Widget build(BuildContext context) {
    final misTurnos = _turnosBloc.horarios;
    return StreamBuilder<Object>(
      stream: _turnosBloc.selectedDateStream,
      builder: (context, snapshot) {
        List<Widget> lstRadioBtn = [];
        snapshot.data ?? _turnosBloc.selectedDateSink(_turnosBloc.horarios.keys.first);
        List<String> _schedules = misTurnos[snapshot.data];
        for (var item in _schedules) {
          final Widget radioBtn = 
          StreamBuilder(
            stream: _turnosBloc.selectedHourStream,
            builder: (context,snapshot){
              return RadioButton(item, item, null, _turnosBloc, snapshot);
            });
          lstRadioBtn.add(radioBtn);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lstRadioBtn
        );
      }
    );
  }
}