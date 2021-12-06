import 'package:app_pelu/src/util/bloc/validator.dart';
import 'package:app_pelu/src/util/models/turnosCliente_data.dart';
import 'package:app_pelu/src/util/models/servicios_data.dart';
import 'package:rxdart/subjects.dart';

class TurnosBloc with Validators{
  final _datesController = BehaviorSubject<List<String>>();
  final _hoursController = BehaviorSubject<List<String>>();
  final _selectedDateController = BehaviorSubject<String>();
  final _selectedHourController = BehaviorSubject<String>();
  final _selectedServiceController = BehaviorSubject<Servicios>();
  final _misTurnosController = BehaviorSubject<List<TurnosCliente>>();
  final _misServiciosController = BehaviorSubject<List<Servicios>>();

  Function(List<String>) get datesSink  => _datesController.sink.add;
  Function(List<String>) get hoursSink => _hoursController.sink.add;
  Function(String)  get selectedDateSink  => _selectedDateController.sink.add;
  Function(String)  get selectedHourSink => _selectedHourController.sink.add;
  Function(Servicios)  get selectedServiceSink => _selectedServiceController.sink.add;
  Function(List<TurnosCliente>) get misTurnosSink => _misTurnosController.sink.add; 
  Function(List<Servicios>) get misServiciosSink => _misServiciosController.sink.add;

  Stream<List<String>> get datesStream  => _datesController.stream;
  Stream<List<String>> get hoursStream => _hoursController.stream;
  Stream<String> get selectedDateStream  => _selectedDateController.stream;
  Stream<String> get selectedHourStream => _selectedHourController.stream;
  Stream<Servicios> get selectedServiceStream => _selectedServiceController.stream;
  Stream<List<TurnosCliente>> get misTurnosStream => _misTurnosController.stream;
  Stream<List<Servicios>> get misServiciosStream => _misServiciosController.stream;

  List<String> get dates  => _datesController.value;
  List<String> get hours => _hoursController.value;
  String get selectedDate  => _selectedDateController.value;
  String get selectedHour => _selectedHourController.value;
  Servicios get selectedService => _selectedServiceController.value;
  List<TurnosCliente> get misTurnos => _misTurnosController.value;
  List<Servicios> get misServicios => _misServiciosController.value;

  dispose(){
    _datesController?.close();
    _hoursController?.close();
    _selectedDateController?.close();
    _selectedHourController?.close();
    _selectedServiceController?.close();
    _misTurnosController?.close();
    _misServiciosController?.close();
  }
}