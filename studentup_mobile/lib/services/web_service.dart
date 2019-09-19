import 'package:url_launcher/url_launcher.dart';

class WebService {
  Future<bool> launchURLInDefaultBrowser(String url) async {
    String _url = url;
    if (!_url.startsWith('http')) _url = 'http://' + _url;
    if (await canLaunch(_url)) {
      try {
        await launch(_url);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}
