import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/parse_month.dart';
import 'package:flutter/material.dart';

class TurnoContainer extends StatelessWidget {

final String date ;
final TurnosBloc _turnosBloc ;
TurnoContainer(this.date,this._turnosBloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _turnosBloc.selectedHourSink('');
          _turnosBloc.selectedDateSink(date);
        },
        child: _createContainer(context)
      ));
  }

  _createContainer(context) {
    List<String> fecha = date.split('-');
    DateTime dateTurno = DateTime(int.parse(fecha[0]),int.parse(fecha[1]),int.parse(fecha[2]));

    return StreamBuilder<Object>(
      stream: _turnosBloc.selectedDateStream,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width / 4.5,
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 180),
          decoration: BoxDecoration(
            gradient: snapshot.data == date ? LinearGradient(
              colors: [
                Colors.indigo,
                Colors.indigo[300],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.circular(10),
            color: snapshot.data == date ? null : Colors.indigo[50]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(getMonthName(dateTurno.month),style: TextStyle(color: _turnosBloc.selectedDate == date ? Colors.white : Colors.indigo[800])),
              Text(getDayName(dateTurno.weekday).substring(0,3),style: TextStyle(color: _turnosBloc.selectedDate == date ? Colors.white : Colors.indigo[800])),
              Text(dateTurno.day.toString(),style: TextStyle(color: _turnosBloc.selectedDate == date ? Colors.white : Colors.indigo[800]))
            ],
          ),
        );
      }
    );
  }
}