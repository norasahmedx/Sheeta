import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/development_illustration.png', // Add your illustration asset
              height: 250,
              width: 250,
              // Adjust the height and width as needed
            ),
            const SizedBox(height: 16),
            const TextTitle(txt: 'Screen in Development'),
            const SizedBox(height: 16),
            const Text(
              'We\'re working hard to bring you an amazing experience.\nStay tuned for updates!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
