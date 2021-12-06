import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefs{
    Future<int> getId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int id = prefs.getInt('id');
      return id;
  }

    setId(int id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('id', id);
  }

  setPhoto(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photo', path);
  }

  Future getPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String path = prefs.getString('photo');
    return path;
    
  }
  setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
  }
  Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone');
    return phone;
  }
}