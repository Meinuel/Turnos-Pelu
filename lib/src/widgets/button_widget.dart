import 'dart:convert';

import 'package:app_pelu/main.dart';
import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/provider/user_provider.dart';
import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/shared_preferences.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'bottomModal_widget.dart';

class MyButton extends StatelessWidget {
  final String text;
  final ContactoBloc contactoBloc;
  final String nextPage ;
  final UserData userData;
  MyButton(this.text,this.contactoBloc,this.nextPage,this.userData);
  @override

  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: contactoBloc.isResolveStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => contactoBloc.isResolve ? Colors.indigo[400] : Colors.grey[350])),
            onPressed: !contactoBloc.isResolve ? null : () => nextPage == 'Largo' ? _validateBeforeRegister(context) : _validateLargo(context,nextPage,contactoBloc), 
            child: contactoBloc.isResolve ? Text(text,style: TextStyle(color: Colors.white)) : Text('Espere...')
        );
      }
    );
  }

  _validateBeforeRegister(context){
    if(contactoBloc.name != null && contactoBloc.birth != null && contactoBloc.phone != null){
      final bool isValid = EmailValidator.validate(contactoBloc.email);
      if(isValid){
        Navigator.pushNamed(context, nextPage,arguments: [contactoBloc,userData]);
      }else{
        createModal(context,'Revisa que todos los datos esten bien cargados!');
      }
    }else{
      createModal(context,'Revisa que todos los datos esten bien cargados!');
    }
  }

  _validateLargo(context,String nextPage,ContactoBloc contacto) async { 
    if(contactoBloc.hair != null){
      contactoBloc.isResolveSink(false);
      // String photo64 = contactoBloc.photo != null ? await _getBase64(contactoBloc.photo) : '';
      var xmlCliente = contactoBloc.isEditing ? UserProvider().updateCliente(contactoBloc, userData.id): UserProvider().clienteCreate(contactoBloc);
      final List<String> idVoucher = await triggerRequest(xmlCliente,contactoBloc.isEditing ? 'updateCliente' : 'clienteCreate');
      final List<dynamic> lstRsp = parseRsp(idVoucher);
      if(!lstRsp[0]){
        var xmlClienteById = UserProvider().getClienteById(int.parse(lstRsp[1]['Id']));
        dynamic clientData = await triggerRequest(xmlClienteById, 'getClienteById');
        var json = jsonDecode(clientData[0]);
        UserData userData = UserData(int.parse(json['Id']),int.parse(json['SucursalId']),'${json['Nombre']} ${json['Apellido']}',json['Celular'],json['Email'],json['Cumple_DDMM'],json['CodigoVoucher'],json['LargoCabelloCodigo'],json['AltaCliente'],int.parse(json['YaCalificoEnGoogle']),int.parse(json['DiasPenalidadTurno']),contactoBloc.photo ?? null);
        userData.photo != null ? await SharedPrefs().setPhoto(userData.photo.path) : DoNothingAction();
        SharedPrefs().setId(int.parse(json['Id']));
        SharedPrefs().setPhone(contactoBloc.phone);
        Navigator.pushReplacementNamed(context, 'Principal',arguments: userData);
      }else if(lstRsp[0] == '0'){
        contactoBloc.photo != null ? await SharedPrefs().setPhoto(contactoBloc.photo.path) : DoNothingAction();
        if(contactoBloc.isEditing){
          UserData userData1 = UserData(userData.id,userData.sucursalId,'${contactoBloc.name}',userData.phone,contactoBloc.email,contactoBloc.birth,userData.codigoVocuher,contactoBloc.hair,userData.altaCliente,userData.isQualified,userData.penalty,contactoBloc.photo ?? null);
          Navigator.pushReplacementNamed(context, 'Principal',arguments: userData1);
        }
      }else if(lstRsp[0] == '1'){
        contactoBloc.isResolveSink(true);
        createModal(context, 'Error al generar usuario, intente de nuevo');
      }else{
        contactoBloc.isResolveSink(true);
        createModal(context, 'Error de comunicacion');
      }
    }else{
      createModal(context, 'Elegí al menos una de las opciones');
    }}
  }

  // _getBase64(XFile photo) async {
  //   final bytes = await File(photo.path).readAsBytes();
  //   String photo64 =  base64.encode(bytes);
  //   return photo64;
  // }