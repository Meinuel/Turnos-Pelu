import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  const url = 'https://g.page/SalonAliceBA/review?nr';
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    )) {
      throw 'Could not launch $url';
    }
}