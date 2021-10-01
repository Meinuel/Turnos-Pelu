import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:flutter/material.dart';

class ContainerServicios extends StatelessWidget {
  final TurnosBloc _turnosBloc;
  ContainerServicios(this._turnosBloc);
  final List<String> _servicios = ['Corte','Lavado','Bla','Blah'];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _createModal(context) ,
      child: Container(
        height: screenSize.height / 15,
        width: screenSize.width / 3,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(),
          borderRadius: BorderRadius.circular(5)
        ),
        child: StreamBuilder<Object>(
          stream: _turnosBloc.selectedServiceStream,
          builder: (context, snapshot) {
            return Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(snapshot.data ?? _servicios[0]),
                Icon(Icons.arrow_drop_down)
              ],
            ));
          }
        ),
      ),
    );
  }

  _createModal(context) {
    List<Widget> lstTiles = [];
    for (var item in _servicios) {
      final tile = ListTile(
        title: Text(item),
        onTap: () {
          _turnosBloc.selectedServiceSink(item);
          Navigator.pop(context);},
      );
      lstTiles.add(tile);
    }
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
      context: context, 
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: lstTiles
          ),
        );
      });
  }
}