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
}