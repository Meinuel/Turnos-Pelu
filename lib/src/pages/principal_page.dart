import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/widgets/userImage_widget.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  final Map<String,String> mapMenu = {'Solicitar Turno' : 'Solicitar', 'Mis Turnos' : 'Turnos','Mis Vouchers' : 'Vouchers','Calificanos' : 'Calificar' , 'Invitar Amigos' : 'Invitar' , 'Editar Perfil' : 'Perfil'};
  @override
  Widget build(BuildContext context) {

    UserData userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: _myProfile(userData),
          ),
          Divider(color: Colors.grey[350]),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _createMenu(context),
            ),
          ),
        ]
      ),
    );
  }

  _createMenu(BuildContext context) {
    List<Widget> lstBtns = [];
    for (var item in mapMenu.keys) {
      final btn = Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height / 17,
        child:ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
          ),
          child:Text(item),
          onPressed: () => Navigator.pushNamed(context, mapMenu[item]),
      ));
      lstBtns.add(btn);
    }
    return lstBtns;
  }

  _myProfile(UserData userData) {
    return SafeArea(
      child: Row(
        children: [
          UserImage(userData.photo == null ? '01' : userData.photo.path),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(userData.name,style: TextStyle(fontSize: 18),),
              SizedBox(height: 10),
              Text(userData.email)
            ]
          )
        ],
      ),
    );
  }
}