import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class UrlServices {
  static openWhatsAppWithMsg(String whatsappNo, String message) {
    final url =
        'https://api.whatsapp.com/send?phone=$whatsappNo&text=${Uri.encodeComponent(message)}';
    appLuncher(url);
  }

  static updateUrl() async {
    String url;
    if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/';
    } else {
      url = 'https://play.google.com/store/apps/details?id=';
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> appLuncher(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
