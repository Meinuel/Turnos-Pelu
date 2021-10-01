import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefs{
    Future<String> getId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString('id');
      return id;
  }

    setId(String id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', id);
  }
}