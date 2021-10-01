class TurnosProvider{
  getSchedule(){
    return Future.delayed(Duration(seconds: 3));
  }
  getMisTurnos(){
    return Future.delayed(Duration(seconds: 3));
  }
  cancelTurnos(){
    return Future.delayed(Duration(seconds: 3));
  }
}