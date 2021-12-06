import 'package:image_picker/image_picker.dart';

class UserData{
  final int id;
  final int sucursalId;
  final String name;
  final String phone;
  final String email;
  final String birth;
  final String codigoVocuher;
  final String long;
  final String altaCliente;
  final int isQualified;
  final int penalty;
  final XFile photo;
  UserData(this.id,this.sucursalId,this.name,this.phone,this.email,this.birth,this.codigoVocuher,this.long,this.altaCliente,this.isQualified,this.penalty,this.photo);
}