import 'dart:ui';

import 'package:app_pelu/src/util/icon_data.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/util/routes.dart';
import 'package:app_pelu/src/widgets/userImage_widget.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final Map<String,String> mapMenu = {'Solicitar Turno' : 'Solicitar', 'Mis Turnos' : 'Turnos','Calificanos' : 'Calificar' , 'Editar Perfil' : 'Perfil'};

  @override
  Widget build(BuildContext context) {

    UserData userData = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: _myProfile(userData),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _createMenu(context,userData),
            ),
          ),
        ]
      ),
    );
  }

  _createMenu(BuildContext context,UserData userData) {
    List<Widget> lstBtns = [];
    for (var item in mapMenu.keys) {
      final btn = GestureDetector(
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(getIcon(item), color: Colors.white),
              Text(item,style: TextStyle(color: Colors.white),),
              Container()
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.4),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(0, 5), // changes position of shadow
              ),  
            ],
            border: Border.all(color: Colors.transparent,style: BorderStyle.solid,width: 1),borderRadius:BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.indigo,
                Colors.indigo[300],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        ),
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 17,
      ),
      onTap: () => setRoute(mapMenu[item], userData,context,false,null));
      lstBtns.add(btn);
    }
    return lstBtns;
  }

  _myProfile(UserData userData) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          boxShadow: [
              BoxShadow(
                color: const Color(0xffb4BA661),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),  
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xffb4BA661),style: BorderStyle.solid)
        ),
        child: Row(
          children: [
            UserImage(userData.photo),
            //SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text('${userData.name.split(' ')[0]} ${userData.name.split(' ')[1]}',style: TextStyle(fontSize: 18,color: Color(0xFF498C5A),fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(userData.email,style: TextStyle(color: Color(0xFF498C5A),fontWeight: FontWeight.bold,fontSize: 13))
              ]
            )
          ],
        ),
      ),
    );
  }

}