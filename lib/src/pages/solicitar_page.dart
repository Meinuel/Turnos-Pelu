import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/widgets/schedule_widget.dart';
import 'package:app_pelu/src/widgets/servicio_widget.dart';
import 'package:app_pelu/src/widgets/turnoContainer_widget.dart';
import 'package:app_pelu/src/widgets/turnosListContainer_widget.dart';
import 'package:flutter/material.dart';

class Solicitar extends StatefulWidget {

  @override
  _SolicitarState createState() => _SolicitarState();
}

class _SolicitarState extends State<Solicitar> {
  TurnosBloc _turnosBloc = TurnosBloc(); 
  Future turnos = TurnosProvider().getSchedule();
  final Map<String,List<String>> mockTurnos = {'7/10/2021' : ['17hs','18hs'],'8/10/2021' : ['15hs','17hs','18hs'],'9/10/2021' : ['16hs','18hs','20hs','22hs'],'11/10/2021' : ['17hs','18hs'],'13/10/2021' : ['17hs','18hs'],'15/10/2021' : ['17hs','18hs'],'20/10/2021' : ['15hs','17hs','18hs'],'30/10/2021' : ['17hs','18hs'],'02/11/2021' : ['17hs','18hs'],'5/11/2021' : ['17hs','18hs']};
  @override
  void initState() {
    super.initState();
    turnos.then((value) => {
      _turnosBloc.horariosSink(mockTurnos)
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solicitud de Turnos')),
      body: Container(
        child: StreamBuilder(
          stream: _turnosBloc.horariosStream,
          builder: (context,snapshot) => snapshot.hasData ? _createTurnos(snapshot) : Center(child: CircularProgressIndicator()))),
    );
  }

  _createTurnos(AsyncSnapshot snapshot) {
    List<Widget> lstContainer = [];
    _turnosBloc.selectedDateSink(_turnosBloc.horarios.keys.first);

    for (var item in snapshot.data.keys) {
      lstContainer.add(TurnoContainer(item,_turnosBloc));
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
        snapshot.hasData ? Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(margin: EdgeInsets.only(left: 10), child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(alignment: Alignment.centerLeft,child: Text('Hora',style: TextStyle(fontSize: 20))),
                    Container(child: StreamBuilder<Object>(
                      stream: _turnosBloc.selectedDateStream,
                      builder: (context, snapshot) {
                        return Text(_turnosBloc.selectedDate);
                      }
                    ))
                  ],
                )),
                Schedule(_turnosBloc),
                Container()
              ],
            ),
          ),
        ) : Container(),
        Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: [
              Divider(color: Colors.grey[400],endIndent: 15,indent: 15),
              Container(margin: EdgeInsets.only(left: 10), child: Align(alignment: Alignment.centerLeft,child: Text('Servicio',style: TextStyle(fontSize: 20)))),
              SizedBox(height: 10),
              ContainerServicios(_turnosBloc),
            ],
          ),
        ),
        Align(alignment: Alignment.centerRight,heightFactor: 1.5,widthFactor: 3,child: ElevatedButton(onPressed: (){}, child: Text('Reservar'))),
      ],
    );
  }
}