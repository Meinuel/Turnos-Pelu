import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/bloc/turnos_bloc.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String _title;
  final String _item;
  final ContactoBloc _contactoBloc;
  final TurnosBloc _turnosBloc;
  final AsyncSnapshot snapshot;
  RadioButton(this._title,this._item,this._contactoBloc,this._turnosBloc,this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_title),
      leading: Radio(
        value: _item, 
        groupValue: snapshot.data, 
        onChanged: (value){
          print(_title);
          _turnosBloc == null ? _contactoBloc.hairSink(value) : _turnosBloc.selectedHourSink(value);
        }));
  }
}