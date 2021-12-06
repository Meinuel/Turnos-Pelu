import 'package:flutter/material.dart';

getIcon(String item){
  return mapIcons[item];
}
final Map<String,IconData> mapIcons = {
  'Solicitar Turno' : Icons.content_cut_rounded,
  'Mis Turnos'      : Icons.event,
  'Mis Vouchers'    : Icons.radar_rounded,
  'Calificanos'     : Icons.star_border,
  'Invitar Amigos'  : Icons.person,
  'Editar Perfil'   : Icons.edit
};