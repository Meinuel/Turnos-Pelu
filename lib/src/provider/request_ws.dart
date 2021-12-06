  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'dart:convert' as convert;
  import 'package:xml/xml.dart';
  
Future<List<String>> triggerRequest(xml,method) async {
    var url = Uri.parse('https://salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php'); 
    String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));
    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Host':'salonalice.com.ar',
          'Content-Type' : 'text/xml; charset=utf-8',
          'SOAPAction'  : 'https://www.salonalice.com.ar/landings/wsturnos/test/serviciosTurnos.php/$method',
          'authorization': basicAuth
        },
        body: convert.utf8.encode(xml)
      );
      var rsp = response.body.replaceAll('&quot', '').replaceAll(';', '');
      List<String> lstObjects = [];
      if(rsp == ''){
        return ['{"codigo":"1"}'];
      }else{
        final raw = XmlDocument.parse(rsp);
        bool isObj = false;
        String object = '';
        
        for (var unit in raw.innerText.codeUnits){
          String character = String.fromCharCode(unit);
          if(character == '{'){
            isObj = true;
            object = character + '"';
          }else if(character == ':'){
            object = object + '"' + character + '"';
          }else if(character == ','){
            object = object + '"' + character + '"';
          }else{
            if(character == '}'){
              isObj = false;
              object = object + '"' + character;
              lstObjects.add(object);
              object = '';
            }else{
              if(isObj == true){
                object = object + character;
              }
            }
          }
        } 
        return lstObjects;
      }
    } catch (e) {
      return ['{"codigo":"1"}'];
    }
  }