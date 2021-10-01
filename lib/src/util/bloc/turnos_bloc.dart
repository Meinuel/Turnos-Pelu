import 'package:app_pelu/src/util/bloc/validator.dart';
import 'package:rxdart/subjects.dart';

class TurnosBloc with Validators{
  final _horariosController = BehaviorSubject<Map<String,List<String>>>();
  final _selectedDateController = BehaviorSubject<String>();
  final _selectedHourController = BehaviorSubject<String>();
  final _selectedServiceController = BehaviorSubject<String>();
  final _misTurnosController = BehaviorSubject<List<Map<String,String>>>();

  Function(Map<String,List<String>>) get horariosSink  => _horariosController.sink.add;
  Function(String)  get selectedDateSink  => _selectedDateController.sink.add;
  Function(String)  get selectedHourSink => _selectedHourController.sink.add;
  Function(String)  get selectedServiceSink => _selectedServiceController.sink.add;
  Function(List<Map<String,String>>) get misTurnosSink => _misTurnosController.sink.add; 

  Stream<Map<String,List<String>>> get horariosStream  => _horariosController.stream;
  Stream<String> get selectedDateStream  => _selectedDateController.stream;
  Stream<String> get selectedHourStream => _selectedHourController.stream;
  Stream<String> get selectedServiceStream => _selectedServiceController.stream;
  Stream<List<Map<String,String>>> get misTurnosStream => _misTurnosController.stream;

  Map<String,List<String>> get horarios  => _horariosController.value;
  String get selectedDate  => _selectedDateController.value;
  String get selectedHour => _selectedHourController.value;
  String get selectedService => _selectedServiceController.value;
  List<Map<String,String>> get misTurnos => _misTurnosController.value;

  dispose(){
    _horariosController?.close();
    _selectedDateController?.close();
    _selectedHourController?.close();
    _selectedServiceController?.close();
    _misTurnosController?.close();
  }
}