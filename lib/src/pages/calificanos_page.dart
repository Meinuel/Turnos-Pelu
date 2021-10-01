import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Calificanos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(child: Text('Go to Google'),onPressed: () => _launchURL()));
  }

  _launchURL() async {
  const url = 'https://g.page/SalonAliceBA/review?nr';
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true); //forceWebView
  } else {
    throw 'Could not launch $url';
  }
}
}
