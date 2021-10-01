import 'package:app_pelu/src/util/bloc/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ContactoBloc with Validators{
  
  final _nameController = BehaviorSubject<String>();
  final _birthController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _photoController = BehaviorSubject<XFile>();
  final _hairLengthController = BehaviorSubject<String>();
  final _isResolveController = BehaviorSubject<bool>();

  Function(String) get nameSink  => _nameController.sink.add;
  Function(String) get birthSink => _birthController.sink.add;
  Function(String) get phoneSink => _phoneController.sink.add;
  Function(String) get emailSink => _emailController.sink.add;
  Function(XFile)  get photoSink => _photoController.sink.add;
  Function(String) get hairSink  => _hairLengthController.sink.add;
  Function(bool) get isResolveSink => _isResolveController.sink.add;

  Stream<String> get nameStream  => _nameController.stream;
  Stream<String> get birthStream => _birthController.stream;
  Stream<String> get phoneStream => _phoneController.stream.transform( validatePhone );
  Stream<String> get emailStream => _emailController.stream.transform( validateEmail );
  Stream<XFile>  get photoStream => _photoController.stream; 
  Stream<String> get hairStream  => _hairLengthController.stream;
  Stream<bool> get isResolveStream   => _isResolveController.stream;

  String get name  => _nameController.value;
  String get birth => _birthController.value;
  String get phone => _phoneController.value;
  String get email => _emailController.value;
  XFile  get photo => _photoController.value;
  String get hair  => _hairLengthController.value;
  bool get isResolve => _isResolveController.value;

  dispose(){
    _nameController?.close();
    _birthController?.close();
    _phoneController?.close();
    _emailController?.close();
    _photoController?.close();
    _hairLengthController?.close();
    _isResolveController?.close();
  }
}