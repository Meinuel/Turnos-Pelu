import 'dart:async';
import 'package:email_validator/email_validator.dart';

class Validators {
  
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData:  ( email, sink ){
      final bool isValid = EmailValidator.validate(email);
      isValid ? sink.add(email) : sink.addError('mail invalido');
    }
  );
  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData:  ( phone, sink ){
      if ( phone.length != 10 ){
        sink.addError('teléfono inválido');
      }else{
        sink.add(phone);
      }
    }
  );
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData:  ( name, sink ){
      int lastName = 0;
      for (var unit in name.codeUnits){
        String character = String.fromCharCode(unit);
        if(lastName == 0){
          if(character == ' '){
            lastName = 1;
          }
        }else{
          lastName = 2;
        }
      }
      lastName == 2 ? sink.add(name) : sink.addError('agregar apellido');
    }
  );
}