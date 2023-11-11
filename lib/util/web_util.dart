import 'package:url_launcher/url_launcher.dart';

class WebUtil {
  static Future<void> openNewTab(String url, {bool isNewTab = true}) =>
      launchUrl(Uri.parse(url), webOnlyWindowName: isNewTab ? '_blank' : '_self');
}
