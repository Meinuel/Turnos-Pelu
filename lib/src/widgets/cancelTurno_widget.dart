import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:flutter/material.dart';

class CancelTurno extends StatefulWidget {

  @override
  _CancelTurnoState createState() => _CancelTurnoState();
}

class _CancelTurnoState extends State<CancelTurno> {
  bool isCancel = false ;
  @override
  Widget build(BuildContext context) {
    _future(isCancel);
    return !isCancel ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Seguro queres cancelar ?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  isCancel = true;   
                });
              }, child: Text('Si')),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('No')),
            ],
          )
        ],
      ) : Center(child: CircularProgressIndicator());
  }

  void _future(bool isCancel) {
    if(isCancel){
      Future cancel = TurnosProvider().cancelTurnos();
      cancel.then((value) => Navigator.popAndPushNamed(context, 'Turnos'));
    }
  }
}