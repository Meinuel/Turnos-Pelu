import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/contacto_datos.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/button_widget.dart';
import 'package:app_pelu/src/widgets/spinner_widget.dart';
import 'package:app_pelu/src/widgets/textFields_widget.dart';
import 'package:app_pelu/src/widgets/userImage_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ContactoBloc _contactoBloc = ContactoBloc();
  @override
  Widget build(BuildContext context) {
    final List<dynamic> props = ModalRoute.of(context).settings.arguments;
    final UserData userData = props[0];
    final String phone = props[1];

    _isEditing(userData,phone);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                  ),
                  StreamBuilder<XFile>(
                    stream: _contactoBloc.photoStream,
                    builder: (context, snapshot) {
                      return Container(
                        color: Colors.grey.shade300,
                        height: MediaQuery.of(context).size.height / 6,
                        child: Center(child: snapshot.hasData ? UserImage(snapshot.data) : Text('Si queres podes agregar tu foto!'))
                        );
                    }
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 8,
                    left: 10,
                    child: FloatingActionButton(
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
                  children: _createContactForm(userData),
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

  _createContactForm(UserData userData) {
    List<Widget> contactFormWidgets = [];
    for (var item in mapContacto) {
      contactFormWidgets.add(
        MyTextFields(item['label'], item['helper'], item['hint'], item['icon'],item['type'],_contactoBloc,userData)
      );
    }
    contactFormWidgets.add(MySpinner(_contactoBloc));
    _contactoBloc.isResolveSink(true);
    contactFormWidgets.add(
      Align(
        alignment: Alignment.bottomRight,
        widthFactor: 2.8,
        child: MyButton('Hecho!',_contactoBloc,'Largo',userData)));
    return contactFormWidgets;
  }

  void _isEditing(UserData userData,String phone) {
    if(userData != null){
      _contactoBloc.nameSink(userData.name);
      _contactoBloc.emailSink(userData.email);
      _contactoBloc.phoneSink(userData.phone);
      _contactoBloc.birthSink(userData.birth);
      _contactoBloc.photoSink(userData.photo);
      _contactoBloc.hairSink(userData.long);
      _contactoBloc.isEditingSink(true);
    }else{
      _contactoBloc.phoneSink(phone);
      _contactoBloc.isEditingSink(false);
    }
  }
}