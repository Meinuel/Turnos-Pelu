import 'dart:io';

import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String path;
  UserImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: path == '01' ? Image.asset('assets/profile.png').image : FileImage(File(path)),
          fit: BoxFit.fitWidth
        ),
      ),
    );
  }
}