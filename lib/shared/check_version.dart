import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/shared/app_updater.dart';
import 'package:sheeta/shared/show_popup.dart';

// Function to check for a new version from Firebase
Future<void> checkForNewVersion(context) async {
  try {
    String currentVersion = "0.1.2"; // Replace with your app's current version

    // Fetch the latest version from Firebase.
    var latestVersion = await FirebaseFirestore.instance
        .collection('app_versions')
        .doc('latest')
        .get();

    String latestVersionNumber = latestVersion['version'];
    String latestVersionUrl = latestVersion['version_url'];

    // Compare versions and show a message if a new version is available.
    if (currentVersion.compareTo(latestVersionNumber) < 0) {
      showPopup(
        context: context,
        title: 'Update Available',
        content: 'A new version of the app is available. Update now?',
        actionButtonText: 'Update',
        onPressed: () async {
          await appUpdater(latestVersionUrl);
          Navigator.of(context).pop();
        },
      );
    }
  } catch (e) {
    // showToast("Error checking for new version: $e");
  }
}
