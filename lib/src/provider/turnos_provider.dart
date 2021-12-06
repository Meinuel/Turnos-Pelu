class TurnosProvider{
  getSchedule(){
    return Future.delayed(Duration(seconds: 3));
  }
  getTurnoPedidoPorCliente(int id){
    return '''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:getTurnoPedidoPorCliente xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                <idCliente>$id</idCliente>
              </ser:getTurnoPedidoPorCliente>
          </soapenv:Body>
      </soapenv:Envelope>
    '''; 
  }
  turnoCancelar(int id, String fecha, String hora,String observaciones){
    return '''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:turnoCancelar xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                <turnoId>$id</turnoId>
                <fecha>$fecha</fecha>
                <hora>$hora</hora>
                <observaciones>$observaciones</observaciones>
              </ser:turnoCancelar>
          </soapenv:Body>
      </soapenv:Envelope>
    ''';     
  }
  turnoAsignar(String fecha, String hora, int clienteId, int servicioId){
    return '''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:turnoAsignar xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                  <fecha>$fecha</fecha>
                  <hora>$hora</hora>
                  <clienteId>$clienteId</clienteId>
                  <serviciosId>$servicioId</serviciosId>
              </ser:turnoAsignar>
          </soapenv:Body>
      </soapenv:Envelope>
    ''';
  }
  getReservaHorasDisponibles(String fecha){
    return '''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
          <soapenv:Header/>
          <soapenv:Body>
              <ser:getReservaHorasDisponibles xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                  <fecha>$fecha</fecha>
              </ser:getReservaHorasDisponibles>
          </soapenv:Body>
      </soapenv:Envelope>
    ''';
  }

  getReservaDiasDisponibles(int id) {
      return '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:getReservaDiasDisponibles xmlns="http://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
                <idCliente>$id</idCliente>
            </ser:getReservaDiasDisponibles>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
  }
}
    final getReservaServiciosDisponiblesXml = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:getReservaServiciosDisponibles soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
