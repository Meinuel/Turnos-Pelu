import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String _title;
  final TurnosBloc _turnosBloc;
  final AsyncSnapshot snapshot;
  RadioButton(this._title,this._turnosBloc,this.snapshot);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _turnosBloc.selectedHourSink(_title),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        height: MediaQuery.of(context).size.height / 16,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          color: _turnosBloc.selectedHour == _title ? null : Colors.indigo[50],
          gradient: _turnosBloc.selectedHour == _title ? LinearGradient(
              colors: [
                Colors.indigo,
                Colors.indigo[300],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
          border: Border.all(color: Colors.indigo),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Text('$_title hs',style: TextStyle(color:  _turnosBloc.selectedHour == _title ? Colors.white : Colors.indigo[800])),
      ),
    );
  }
}
