import 'package:app_pelu/src/provider/turnos_provider.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/models/turno_data.dart';
import 'package:app_pelu/src/widgets/appBar_widget.dart';
import 'package:app_pelu/src/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class MisTurnos extends StatefulWidget {
  @override
  _MisTurnosState createState() => _MisTurnosState();
}

class _MisTurnosState extends State<MisTurnos> {
  final TurnosBloc _turnosBloc = new TurnosBloc();
  Future turnos = TurnosProvider().getMisTurnos();
  @override
  void initState() {
    super.initState();
    List<Map<String,String>> mapMisTurnos = [
      {'Fecha' : '5/10/2021' , 'Hora' : '15:00hs' , 'Servicio' : 'Corte'},
      {'Fecha' : '8/11/2021' , 'Hora' : '17:00hs' , 'Servicio' : 'Alisado'}];
    turnos.then((value) => _turnosBloc.misTurnosSink(mapMisTurnos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Mis turnos'),
      body: StreamBuilder<Object>(
        stream: _turnosBloc.misTurnosStream,
        builder: (_, snapshot) => snapshot.hasData ? _createCards(snapshot) : Center(child: CircularProgressIndicator())
      ),
    );
  }
  _createCards(AsyncSnapshot snapshot){
    final List<Map<String,String>> misTurnos = snapshot.data ?? [];
    return ListView.builder(
      itemCount: misTurnos.length,
      itemBuilder: (_,i) {
        final Turno turno = Turno(misTurnos[i]['Fecha'], misTurnos[i]['Hora'], misTurnos[i]['Servicio']); 
        return misTurnos.length == 0 ? Center(child: Text('Todavía no tenés turnos reservados')) : MyCard(turno);
      });
  }
}