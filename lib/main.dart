import 'dart:async';
import 'dart:convert';
import 'package:app_pelu/src/pages/cabello_page.dart';
import 'package:app_pelu/src/pages/perfil_page.dart';
import 'package:app_pelu/src/pages/principal_page.dart';
import 'package:app_pelu/src/provider/request_ws.dart';
import 'package:app_pelu/src/util/bloc/provider_inherited.dart';
import 'package:app_pelu/src/util/routes.dart';
import 'package:app_pelu/src/util/shared_preferences.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/bottomModal_widget.dart';
import 'package:app_pelu/src/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'src/pages/login_page.dart';
import 'src/provider/user_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
                 // 'Solicitar'  : (BuildContext context) => Solicitar(),
                 // 'Turnos'     : (BuildContext context) => MisTurnos(),
                  'Perfil'     : (BuildContext context) => Perfil(),
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
  final streamController = StreamController<bool>.broadcast();
  final buttonController = StreamController<bool>.broadcast();
  TextEditingController _controller = TextEditingController();
  Future<String> phone = SharedPrefs().getPhone();
  //Future<String> mobileNumber = MobileNumber.mobileNumber;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() { 
      buttonController.sink.add(false);
    });
    phone.then((value) => value != null ? _isRegister(value) : streamController.sink.add(false)
    );
  }
  @override
  void dispose() {
    streamController.close();
    buttonController.close();
    super.dispose();
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<Object>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            return !snapshot.hasData ? 
            Center(
              child: CircularProgressIndicator()) :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5),
                  child: PhoneFieldHint(
                    decoration: InputDecoration(
                      hintText: 'Nro Celular',
                      icon: StreamBuilder<Object>(
                        stream: buttonController.stream,
                        builder: (context, btnSnapshot) {
                          return !btnSnapshot.hasData ? Icon(Icons.phone_android) : !btnSnapshot.data ? Icon(Icons.phone_android) : Center(child: CircularProgressIndicator());
                        }
                      )),
                    controller: _controller,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                StreamBuilder<Object>(
                  stream: buttonController.stream,
                  builder: (context, btnSnapshot) {
                    return ElevatedButton(
                      child: Text( !btnSnapshot.hasData ? 'Continuar' : !btnSnapshot.data ? 'Continuar' : 'Espere'),
                      onPressed: btnSnapshot.hasData && _controller.text != '' && !btnSnapshot.data ? () async {
                        buttonController.sink.add(true);
                        final xml = UserProvider().getClienteByCelular(_controller.text);
                        List<String> dataCliente = await triggerRequest(xml, 'getClienteByCelular');
                        List<dynamic> lstRsp = parseRsp(dataCliente);
                        if(!lstRsp[0]){
                          UserData userData = UserData(int.parse(lstRsp[1]['Id']),int.parse(lstRsp[1]['SucursalId']),'${lstRsp[1]['Nombre']} ${lstRsp[1]['Apellido']}',lstRsp[1]['Celular'],lstRsp[1]['Email'],lstRsp[1]['Cumple_DDMM'],lstRsp[1]['CodigoVoucher'],lstRsp[1]['LargoCabelloCodigo'],lstRsp[1]['AltaCliente'],int.parse(lstRsp[1]['YaCalificoEnGoogle']),int.parse(lstRsp[1]['DiasPenalidadTurno']),null);
                          SharedPrefs().setPhone(_controller.text);
                          Navigator.popAndPushNamed(context, 'Principal', arguments: userData);
                        }else if(lstRsp[1]['codigo'] == '1'){
                          setRoute('Login',null,context,false,_controller.text);
                        }else{
                          buttonController.sink.add(false);
                          createModal(context, 'Error de comunicacion');
                        }
                        
                      } : null);
                  }
                )
              ],
            );
          }
        ),
      ),
    );
  }
  _isRegister(String phone) {
    var xml = UserProvider().getClienteByCelular(phone);
    Future<List<String>> isRegister = triggerRequest(xml, 'getClienteByCelular');
    isRegister.then((List<String> dataCliente) async {
      List<dynamic> lstRsp = parseRsp(dataCliente);
      if(!lstRsp[0]){
        final path = await SharedPrefs().getPhoto();
        XFile photo = path != null ? XFile(path) : null;
        UserData userData = UserData(int.parse(lstRsp[1]['Id']),int.parse(lstRsp[1]['SucursalId']),'${lstRsp[1]['Nombre']} ${lstRsp[1]['Apellido']}',phone,lstRsp[1]['Email'],lstRsp[1]['Cumple_DDMM'],lstRsp[1]['CodigoVoucher'],lstRsp[1]['LargoCabelloCodigo'],lstRsp[1]['AltaCliente'],int.parse(lstRsp[1]['YaCalificoEnGoogle']),int.parse(lstRsp[1]['DiasPenalidadTurno']),photo);
        Navigator.pushNamedAndRemoveUntil(context, 'Principal', (route) => false,arguments: userData);
      }else if(lstRsp[1]['codigo'] == '1'){
        setRoute('Login', null, context,true, phone);
      }else{
        createModal(context, 'Error de comunicacion');
      }
    });
  }
}
  parseRsp(List<String> dataCliente){
      final Map<String,dynamic> rsp = jsonDecode(dataCliente[0]);
      bool codigoExist = false;
      for (var item in rsp.keys) {
        if(item == 'codigo'){
          codigoExist = true;
        }
      }
      return [codigoExist,rsp];
  }