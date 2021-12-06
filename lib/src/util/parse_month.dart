String getMonthName(int month){
  switch (month) {
    case 1: 
      return 'Enero';
      break;
    case 2: 
      return 'Febrero';
      break;
    case 3: 
      return 'Marzo';
      break;
    case 4: 
      return 'Abril';
      break;
    case 5: 
      return 'Mayo';
      break;
    case 6: 
      return 'Junio';
      break;
    case 7: 
      return 'Julio';
      break;
    case 8: 
      return 'Agosto';
      break;
    case 9: 
      return 'Septiembre';
      break;
    case 10: 
      return 'Octubre';
      break;
    case 11: 
      return 'Noviembre';
      break;
    case 12: 
      return 'Diciembre';
      break;
    default:
      return 'Osvaldo'; 
  }
}
String getDayName(int i){
  switch (i) {
    case 1:
      return 'Lunes';
      break;
    case 2:
      return 'Martes';
    case 3:
      return 'Miercoles';
      break;
    case 4:
      return 'Jueves';
    case 5:
      return 'Viernes';
      break;
    case 6:
      return 'Sabado';
    case 7:
      return 'Domingo';
    default:
      return 'Osvaldo'; 
  }
}

String getDayTime(String hora){
  if(hora == '01' || hora == '02' || hora == '03' || hora == '04' || hora == '05' || hora == '06' || hora == '07' || hora == '08' || hora == '09' || hora == '10' || hora == '11' || hora == '12'){
    return 'AM';
  }else{
    return 'PM';
  }
}