  import 'package:flutter/material.dart';

createModal(context,message) {
    showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),context: context, builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Align(alignment: Alignment.center,child: Text(message)),
      );
    });
  }