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
  MyButton(this.text,this.contactoBloc,this.nextPage);
  @override

  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: contactoBloc.isResolveStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => contactoBloc.isResolve ? Colors.indigo[400] : Colors.grey[350])),
            onPressed: !contactoBloc.isResolve ? null : () => nextPage == 'Largo' ? _validateBeforeRegister(context) : _validateLargo(context), 
            child: contactoBloc.isResolve ? Text(text,style: TextStyle(color: Colors.white)) : Text('Espere...')
        );
      }
    );
  }

  _validateBeforeRegister(context){
    if(contactoBloc.name != null && contactoBloc.birth != null && contactoBloc.phone.length == 10){
      final bool isValid = EmailValidator.validate(contactoBloc.email);
      if(isValid){
        print('PIOLA');
        Navigator.popAndPushNamed(context, nextPage,arguments: contactoBloc);
      }else{
        print('ERROR');
        createModal(context,'Revisa que todos los datos esten bien cargados!');
      }
    }else{
      print('ERROR');
      createModal(context,'Revisa que todos los datos esten bien cargados!');
    }
  }

  _validateLargo(context) async { 
    if(contactoBloc.hair != null){
      contactoBloc.isResolveSink(false);
      // String photo64 = contactoBloc.photo != null ? await _getBase64(contactoBloc.photo) : '';
      Future idVoucher = UserProvider().getIdVoucher(contactoBloc);

      idVoucher.then((value) async {
        await SharedPrefs().setId('123456');
        final UserData userData = UserData(contactoBloc.email, contactoBloc.name, contactoBloc.phone, contactoBloc.photo, contactoBloc.birth, contactoBloc.hair);
        Navigator.popAndPushNamed(context, 'Principal',arguments: userData);
      });
    }else{
      createModal(context, 'Elegí al menos una de las opciones');
    }
  }

  // _getBase64(XFile photo) async {
  //   final bytes = await File(photo.path).readAsBytes();
  //   String photo64 =  base64.encode(bytes);
  //   return photo64;
  // }

}