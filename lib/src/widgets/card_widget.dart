import 'dart:ui';
import 'package:app_pelu/src/util/models/turno_data.dart';
import 'package:app_pelu/src/util/parse_month.dart';
import 'package:app_pelu/src/widgets/cancelTurno_widget.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Turno turno;
  MyCard(this.turno);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List fecha = turno.fecha.split('/');
    final turnoDate = DateTime(int.parse(fecha[2]), int.parse(fecha[1]), int.parse(fecha[0]));
    final today = DateTime.now();
    final difference = today.difference(turnoDate).inDays;

    return Card(
      child: Container(
        height: screenSize.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left:10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${getDayName(turnoDate.weekday)} ${turnoDate.day} de ${getMonthName(turnoDate.month)}'),
                      Text(turno.hora),
                      Text(turno.servicio),
                      Text('En ${difference.toString().substring(1,difference.toString().length)} días')
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  height: screenSize.height / 8,
                  width: screenSize.height / 8,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: screenSize.height / 32,
                        width: screenSize.height / 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                          gradient: LinearGradient(colors: [Colors.red[400],Colors.red[700]])
                        ),
                        child: Text(getMonthName(turnoDate.month),style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7, 
                              offset: Offset(0, 2),
                            )],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),color: Colors.grey[100]),
                          alignment: Alignment.center,
                          child: Text(fecha[0],style: TextStyle(fontSize: 40)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red[700])),onPressed: () => _cancelTurno(context), child: Text('Cancelar')))
          ],
        ),
      ),
    );
  }

  _cancelTurno(context) async{
    showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),context: context, builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: CancelTurno());
    }).then((value) => Navigator.popAndPushNamed(context, 'Turnos'));
  }
}