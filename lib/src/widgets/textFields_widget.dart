import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_number/mobile_number.dart';

class MyTextFields extends StatefulWidget {
  final String labelText;
  final String helperText ;
  final String hintText;
  final IconData icon;
  final int type;
  final ContactoBloc _contactoBloc;
  MyTextFields(this.labelText,this.helperText,this.hintText,this.icon,this.type,this._contactoBloc);

  @override
  _MyTextFieldsState createState() => _MyTextFieldsState();
}

class _MyTextFieldsState extends State<MyTextFields> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.type == 8 ? widget._contactoBloc.nameStream : widget.type == 3 ? widget._contactoBloc.phoneStream : widget._contactoBloc.emailStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal:50),
            child: TextField(
              onChanged: (text) => _sink(text,widget.type),
              keyboardType: _textFieldType(widget.type),
              decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(widget.icon),
                hintText: widget.hintText,
                helperText: widget.helperText,
                labelText: widget.labelText,
                filled: true),
            ),
        );
      }
    );
  }

  _textFieldType(int type) {
    switch (type) {
      case 8:
        return TextInputType.name;
        break;      
      case 3 :
        return TextInputType.phone;
        break;
      case 5 :
        return TextInputType.emailAddress;     
        break;   
      default:
    }
  }

  void _sink(String text,type) {
        switch (type) {
      case 8:
        widget._contactoBloc.nameSink(text);
        break;      
      case 3 :
        widget._contactoBloc.phoneSink(text);
        break;
      case 5 :
        widget._contactoBloc.emailSink(text);     
        break;   
      default:
    }
  }
}