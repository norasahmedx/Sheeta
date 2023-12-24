import 'package:flutter/material.dart';

class CaptionInput extends StatelessWidget {
  final TextEditingController descriptionController;
  const CaptionInput({
    super.key,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        controller: descriptionController,
        maxLines: 8,
        decoration: const InputDecoration(
            hintText: "write a caption...", border: InputBorder.none),
      ),
    );
  }
}
