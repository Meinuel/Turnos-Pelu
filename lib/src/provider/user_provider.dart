import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';

class UserProvider{
//-- REGISTRARSE --
  clienteCreate(ContactoBloc contactoBloc) {
    var xml ='''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:createCliente xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
              <nombre>${contactoBloc.name.split(' ')[0]}</nombre>
              <apellido>${contactoBloc.name.split(' ')[1]}</apellido>
              <numeroCelular>${contactoBloc.phone}</numeroCelular>
              <email>${contactoBloc.email}</email>
              <ddmm>${contactoBloc.birth}</ddmm>
              <largoCabelloCodigo>${contactoBloc.hair}</largoCabelloCodigo>
              <sucursalId>1</sucursalId>
            </ser:createCliente>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
    return xml;
  }

  updateCliente(ContactoBloc contactoBloc, int id) {
    var xml ='''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:updateCliente xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
              <clienteId>$id</clienteId>
              <apellido>${contactoBloc.name.split(' ')[1]}</apellido>
              <nombre>${contactoBloc.name.split(' ')[0]}</nombre>
              <email>${contactoBloc.email}</email>
              <ddmm>${contactoBloc.birth}</ddmm>
              <largoCabelloCodigo>${contactoBloc.hair}</largoCabelloCodigo>
            </ser:updateCliente>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
    return xml;
  }
  clienteUploadPicture(){
    //int id, int64 foto
  }

//-- SOLICITAR TURNO --
  reservaDiasDisponiblesGet(){
    // int clienteId
  }
  reservaHorasDisponiblesGet(){
    // string fecha
  }
  turnoAsignar(){
    // int clienteId, string fecha, string hora, int servicioId
  }
//-- VER TURNOS --
  turnosGet(){
    //string fechaDesde, int clienteId
  }  
  turnosCancelar(){
    // int turnoId
  }
//-- CONSULTAR PRECIO --
  serviciosGet(){
    //-- int pMostrarParaTurnos --
  }
  serviciosPreciosGet(){
    // int servicioId, string largoCabelloCodigo
  }
// -- VER VOUCHERS --
  //ver vouchers


  getClienteById(int id){
    var xml ='''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:getClienteById xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                <id>$id</id>
              </ser:getClienteById>
          </soapenv:Body>
      </soapenv:Envelope>
    ''';
    return xml;
  }

  getClienteByCelular(String phone){
    var xml ='''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:getClienteByCelular xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                <celular>$phone</celular>
              </ser:getClienteByCelular>
          </soapenv:Body>
      </soapenv:Envelope>
    ''';
    return xml;
  }
  setUser(ContactoBloc contactoBloc){
    return Future.delayed(Duration(seconds: 5));
  }
  solicitarTurno(){

    return Future.delayed(Duration(seconds: 5));
  }
}