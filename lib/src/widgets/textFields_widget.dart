import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_number/mobile_number.dart';

class MyTextFields extends StatefulWidget {
  final String labelText;
  final String helperText ;
  final String hintText;
  final IconData icon;
  final int type;
  final ContactoBloc _contactoBloc;
  final UserData userData;
  MyTextFields(this.labelText,this.helperText,this.hintText,this.icon,this.type,this._contactoBloc,this.userData);

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
            child: TextFormField(
              enabled: widget.type == 3 ? false : true,
              initialValue: _getInitialValue() ,
              onChanged: (text) => _sink(text),
              keyboardType: _textFieldType(),
              decoration: InputDecoration(
          
                labelStyle: TextStyle(color: widget.type == 3 ? Colors.greenAccent[700] : Colors.grey),
                errorText: snapshot.error,
                icon: Icon(widget.icon,color: widget.type == 3 ? Colors.greenAccent[400] : Colors.grey),
                hintText: widget.hintText,
                helperText: widget.helperText,
                labelText: widget.labelText,
                filled: true),
            ),
        );
      }
    );
  }

  _textFieldType() {
    switch (widget.type) {
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

  void _sink(String text) {
        switch (widget.type) {
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

  String _getInitialValue() {

    if(widget.userData != null){
        switch (widget.type) {
      case 8:
        return widget.userData.name;
        break;      
      case 3 :
        return widget.userData.phone;
        break;
      case 5 :
        return widget.userData.email;     
        break;   
      default:
    }
    }else{
      return widget.type == 3 ?  widget._contactoBloc.phone : '';
    }
    return '';
  }
}