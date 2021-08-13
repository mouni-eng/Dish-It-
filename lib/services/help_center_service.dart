import 'package:url_launcher/url_launcher.dart';

class HelpCenter {
  final String _url = 'tel:+256 700 566587';

  void launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
