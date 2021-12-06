import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:app_pelu/src/util/models/servicios_data.dart';
import 'package:flutter/material.dart';

class ContainerServicios extends StatelessWidget {
  final TurnosBloc _turnosBloc;
  ContainerServicios(this._turnosBloc);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Servicios> servicios = _turnosBloc.misServicios;

    return GestureDetector(
      onTap: () => _createModal(context,servicios),
      child: Container(
        height: screenSize.height / 16,
        width: screenSize.width / 2,
        decoration: BoxDecoration(
          color: Colors.indigo[50],
          border: Border.all(color: Colors.indigo),
          borderRadius: BorderRadius.circular(5)
        ),
        child: StreamBuilder<Servicios>(
          stream: _turnosBloc.selectedServiceStream,
          builder: (context, snapshot) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(snapshot.data == null ? servicios[0].nombre : snapshot.data.nombre,style: TextStyle(color: Colors.indigo[800])),
                  Icon(Icons.arrow_drop_down,color: Colors.indigo)
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  _createModal(context,List<Servicios> servicios) {
    List<Widget> lstTiles = [];
    for (var item in servicios) {
      final tile = ListTile(
        title: Text(item.nombre),
        onTap: () {
          _turnosBloc.selectedServiceSink(item);
          Navigator.pop(context);},
      );
      lstTiles.add(tile);
    }
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
      context: context, 
      builder: (context){
        return Container(
          //height: MediaQuery.of(context).size.height / 1.5,
          child: ListView(
            children: lstTiles
          ),
        );
      });
  }
}