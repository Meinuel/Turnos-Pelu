import 'package:flutter/material.dart';

import 'contacto_bloc.dart';

class Provider extends InheritedWidget{

  final contactoBloc = ContactoBloc();

  Provider({Key key , Widget child})
    : super(key:key , child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContactoBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().contactoBloc;
  }

}