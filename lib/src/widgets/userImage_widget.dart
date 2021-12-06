import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatelessWidget {
  final XFile file;
  UserImage(this.file);

  @override
  Widget build(BuildContext context) {
    final String path = file == null ? '01' : file.path;
    return Container(
      margin: EdgeInsets.all(5),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo[300],style: BorderStyle.solid,width: 2),
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: path == '01' ? Image.asset('assets/icon.png').image : FileImage(File(path)),
          fit: BoxFit.fitWidth
        ),
      ),
    );
  }
}