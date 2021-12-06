import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:app_pelu/src/util/largo_cabello.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/appBar_widget.dart';
import 'package:app_pelu/src/widgets/button_widget.dart';
import 'package:app_pelu/src/widgets/largoImages_widget.dart';
import 'package:flutter/material.dart';

class LargoCabello extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    List<dynamic> props = ModalRoute.of(context).settings.arguments;
    ContactoBloc contactoBloc = props[0];
    UserData userData = props[1];

    return Scaffold(
      appBar: appBar('Largo'),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: 
                _createRadioBtn(contactoBloc,userData)
            ),
            MyButton(contactoBloc.isEditing ? 'Actualizar' : 'Registrarme',contactoBloc,'Principal',userData),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  _createRadioBtn(ContactoBloc contactoBloc,UserData userData) {
    List<Widget> lstRadioBtn = [];
    for (var item in mapImages.keys) {
      final Widget radioBtn  = StreamBuilder(
        stream:contactoBloc.hairStream,
        builder:(_,snapshot){
          contactoBloc.hair == null ? contactoBloc.hairSink('C') : DoNothingAction();
          return LargoWidget(mapImages[item],item,contactoBloc);
        });
      lstRadioBtn.add(radioBtn);
    }
    //lstRadioBtn.add(Align(alignment: Alignment.bottomRight,heightFactor: 3,widthFactor: 2.8,child:MyButton(contactoBloc.isEditing ? 'Actualizar' : 'Registrarme',contactoBloc,'Principal',userData)));
    return lstRadioBtn;
  }
}