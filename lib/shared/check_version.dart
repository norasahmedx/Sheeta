import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/shared/app_updater.dart';
import 'package:sheeta/shared/show_popup.dart';

// Function to check for a new version from Firebase
Future<void> checkForNewVersion(context) async {
  try {
    String currentVersion = "0.1.4"; // Replace with your app's current version

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
        title: 'Sheeta v$latestVersionNumber Available',
        content:
            'Discover enhanced features and a sleeker experience. Elevate your Sheeta now!',
        actionButtonText: 'Update Now',
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
