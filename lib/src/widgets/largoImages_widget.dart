import 'package:app_pelu/src/util/bloc/contacto_bloc.dart';
import 'package:flutter/material.dart';

class LargoWidget extends StatelessWidget {
  final String imageUrl ;
  final String imageKey;
  final ContactoBloc contactoBloc;
  LargoWidget(this.imageUrl,this.imageKey,this.contactoBloc);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => contactoBloc.hairSink(imageKey),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: imageKey == contactoBloc.hair ? Border.all(color: Color(0xFF4BA661)) : null
        ),
        child: Image.asset(imageUrl),
      ),
    );
  }
}