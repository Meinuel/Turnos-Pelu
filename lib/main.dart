import 'package:app_pelu/src/pages/calificanos_page.dart';
import 'package:app_pelu/src/pages/principal_page.dart';
import 'package:app_pelu/src/pages/turnos_page.dart';
import 'package:app_pelu/src/provider/user_provider.dart';
import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/bloc/provider_inherited.dart';
import 'package:app_pelu/src/util/contacto_datos.dart';
import 'package:app_pelu/src/util/shared_preferences.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/button_widget.dart';
import 'package:app_pelu/src/widgets/radio_widget.dart';
import 'package:app_pelu/src/widgets/spinner_widget.dart';
import 'package:app_pelu/src/widgets/textFields_widget.dart';
import 'package:app_pelu/src/widgets/userImage_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'src/pages/solicitar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        routes: { 'Largo'      : (BuildContext context) => LargoCabello(),
                  'Login'      : (BuildContext context) => Login(),
                  'Principal'  : (BuildContext context) => Principal(),
                  'Solicitar'  : (BuildContext context) => Solicitar(),
                  'Turnos'     : (BuildContext context) => MisTurnos(),
                  'Calificar'  : (BuildContext context) => Calificanos()
                  },
        debugShowCheckedModeBanner: false,
        title: 'Sistema de turnos',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Loader(),
      ),
    );
  }
}

class Loader extends StatefulWidget {

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  Future<String> _id = SharedPrefs().getId();
  @override
  void initState() {
    super.initState();
    _id.then((id)=> Navigator.popAndPushNamed(context, 'Login')
      // (id) => id == null ? Navigator.popAndPushNamed(context, 'Login') : _isRegister(id)
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('App pelu'),
            SizedBox(height: 50),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  _isRegister(String id) {
      print('existe usuario');
      Future isRegister = UserProvider().getUser(id);
      final UserData userData = UserData('sieteoctavos78@gmail.com', 'Manuel', '1553154948', null, '23-03', 'M');
      isRegister.then((value) => value != 'OK' ? Navigator.popAndPushNamed(context, 'Principal',arguments: userData) : Navigator.popAndPushNamed(context, 'Login'));
  }

}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ContactoBloc _contactoBloc = ContactoBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  StreamBuilder<XFile>(
                    stream: _contactoBloc.photoStream,
                    builder: (context, snapshot) {
                      return Container(
                        color: Colors.grey.shade300,
                        height: MediaQuery.of(context).size.height / 6,
                        child: Center(child: snapshot.hasData ? UserImage(snapshot.data.path) : Text('Si queres podes agregar tu foto!'))
                        );
                        //child: Center(child: snapshot.hasData ? Image.file(File(snapshot.data.path)): Text('Agrega tu foto')));
                    }
                  ),
                  Positioned(top: 100,left: 10,child: FloatingActionButton(
                    onPressed: () async {
                      XFile pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                      _contactoBloc.photoSink(pickedImage);
                    },
                    child: Icon(Icons.camera_enhance),backgroundColor: Colors.indigo[400]))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _createContactForm(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            )
          ],
        ),
    );
  }

  _createContactForm() {
    List<Widget> contactFormWidgets = [];
    for (var item in mapContacto) {
      contactFormWidgets.add(
        MyTextFields(item['label'], item['helper'], item['hint'], item['icon'],item['type'],_contactoBloc)
      );
    }
    contactFormWidgets.add(MySpinner(_contactoBloc));
    _contactoBloc.isResolveSink(true);
    contactFormWidgets.add(Align(alignment: Alignment.bottomRight,widthFactor: 2.8,child:MyButton('Hecho!',_contactoBloc,'Largo')));
    return contactFormWidgets;
  }
}

class LargoCabello extends StatelessWidget {
final Map<String,String> values = {'C':'Corto','M':'Medio','L':'Largo','EL': 'Extra Largo'};
  @override

  Widget build(BuildContext context) {
    ContactoBloc contactoBloc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Largo de Cabello'),),
      body: Container(
        child: Column(
          children: 
            _createRadioBtn(contactoBloc)
          ,
        ),
      ),
    );
  }

  _createRadioBtn(ContactoBloc contactoBloc) {
    List<Widget> lstRadioBtn = [];
    for (var item in values.keys) {
      final Widget radioBtn  = StreamBuilder(
        stream:contactoBloc.hairStream,
        builder:(_,snapshot){
          return RadioButton(values[item], item, contactoBloc,null,snapshot);
        });
      lstRadioBtn.add(radioBtn);
    }
    lstRadioBtn.add(Align(alignment: Alignment.bottomRight,heightFactor: 3,widthFactor: 2.8,child:MyButton('Registrarme',contactoBloc,'Principal')));
    return lstRadioBtn;
  }
}