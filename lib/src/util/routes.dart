import 'package:app_pelu/src/pages/solicitar_page.dart';
import 'package:app_pelu/src/pages/turnos_page.dart';
import 'package:app_pelu/src/util/models/user_data.dart';
import 'package:flutter/material.dart';
import 'launch_url.dart';

setRoute(String route,UserData userData, BuildContext context, bool pop, String phone) {
    if(route == 'Calificar'){
      launchURL();
    }else if(route == 'Perfil'){
      Navigator.pushNamed(context, route,arguments: userData);
    }else if(route == 'Login'){
      Navigator.pushNamed(context, 'Login',arguments: [userData,phone]);
    }else{
      pop ? Navigator.pushReplacement(context, _getRoute(route, userData)) : Navigator.push(context, _getRoute(route,userData));
    }
  }

Route<Object> _getRoute(String route, UserData userData) {
  if(route == 'Solicitar'){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Solicitar(userData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }else if(route == 'Turnos'){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MisTurnos(userData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  ); 
  }else{
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MisTurnos(userData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );     
  }
}