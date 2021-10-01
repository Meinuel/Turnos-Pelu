import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

class MySpinner extends StatelessWidget {
  final ContactoBloc _contactoBloc ;
  MySpinner(this._contactoBloc);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cake,color: Colors.grey),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => _mySpinner(context),
            child: StreamBuilder<Object>(
              stream: _contactoBloc.birthStream,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                    color: Colors.grey.shade200,
                    ),
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Align(alignment: Alignment.centerLeft,child: Text(snapshot.hasData ? snapshot.data.toString() : 'Cumpleaños',style: TextStyle( color: snapshot.hasData ? Colors.black : Colors.grey[700],fontSize: 16)))
                );
              }
            )),
        ],
    );
  }

  _mySpinner(BuildContext context){
    return showDialog(
      context: context, 
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height/4,          
          child: AlertDialog(
            title: Text('Cumpleaños'),
            content:
                DatePickerWidget(
                  looping: false, // default is not looping
                  firstDate: DateTime(1950, 01, 01),
                  lastDate: DateTime(2030, 1, 1),
                  dateFormat: "dd-MMM",
                  locale: DatePicker.localeFromString('en'),
                  onChange: (DateTime newDate, _) => _contactoBloc.birthSink('${newDate.day}/${newDate.month}'),
                  pickerTheme: DateTimePickerTheme(
                    itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                    dividerColor: Colors.blue,
                  ),
                ),
               // MyButton('Ok')            
          ),
        );
      });
  }
}