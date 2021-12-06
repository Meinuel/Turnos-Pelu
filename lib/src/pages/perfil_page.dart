import 'package:app_pelu/src/util/largo_cabello.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:app_pelu/src/util/parse_month.dart';
import 'package:app_pelu/src/widgets/appBar_widget.dart';
import 'package:app_pelu/src/widgets/userImage_widget.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final UserData userData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBar('Mi Perfil'),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  UserImage(userData.photo),
                  Text(userData.name,style:TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(userData.email,style:TextStyle(fontSize: 17)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.cake,color: Color(0xFF4BA661),size: 35),
                  SizedBox(width: 10),
                  Text('${userData.birth.substring(0,2)} de ${getMonthName(int.parse(userData.birth.substring(2,4)))}',style:TextStyle(fontSize: 20)),
                ],
              ),
              Text('Largo : ${mapLargoCabello[userData.long]}',style: TextStyle(fontSize: 17),),
              Align(alignment: Alignment.bottomRight,widthFactor: 4,child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, 'Login',arguments: [userData,userData.phone]), child: Text('Editar')))
            ],
        ),
      ),
    );
  }
}