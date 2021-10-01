import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/parse_month.dart';
import 'package:flutter/material.dart';

class TurnoContainer extends StatelessWidget {

final String date ;
final TurnosBloc _turnosBloc ;
TurnoContainer(this.date,this._turnosBloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GestureDetector(
      onTap: () {
        print(date);
        _turnosBloc.selectedDateSink(date);
      },
      child: _createContainer(context)));
  }

  _createContainer(context) {
    List<String> fecha = date.split('/');
    DateTime dateTurno = DateTime(int.parse(fecha[2]),int.parse(fecha[1]),int.parse(fecha[0]));

    return StreamBuilder<Object>(
      stream: _turnosBloc.selectedDateStream,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width / 5.5,
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 180),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
            color: snapshot.data == date ? Colors.greenAccent : Colors.grey[350]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(getMonthName(dateTurno.month).substring(0,3)),
              Text(getDayName(dateTurno.weekday).substring(0,3)),
              Text(dateTurno.day.toString())
            ],
          ),
        );
      }
    );
  }
}