import 'package:image_picker/image_picker.dart';

class UserData{
  final String email;
  final String name;
  final String phone;
  final XFile photo;
  final String birth;
  final String long;
  UserData(this.email,this.name,this.phone,this.photo,this.birth,this.long);
}