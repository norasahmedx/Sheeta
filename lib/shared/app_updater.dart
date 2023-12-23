import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

Future<void> appUpdater(String latestVersionUrl) async {
  try {
    // Assume latestVersionUrl is the URL of the download page
    await launchUrl(Uri.parse(latestVersionUrl));
  } catch (e) {
    // Handle errors during the download or installation process
    log("Error during app update: $e");
  }
}
